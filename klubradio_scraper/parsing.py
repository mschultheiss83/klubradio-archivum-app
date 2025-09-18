from __future__ import annotations

import logging
import re
from datetime import datetime
from typing import Any, Dict, List, Optional
from urllib.parse import urljoin

from bs4 import BeautifulSoup, Tag

from .config import settings

# Ungarische Monatsnamen → Monat-Nummer
MONTH_MAP: dict[str, str] = {
    'január': '01', 'február': '02', 'március': '03', 'április': '04',
    'május': '05', 'június': '06', 'július': '07', 'augusztus': '08',
    'szeptember': '09', 'október': '10', 'november': '11', 'december': '12'
}


def parse_hu_date(date_text: str | None) -> Optional[str]:
    """
    Parsen gängiger Klubrádió-Datumsformate (mit/ohne Monatsnamen).
    Rückgabe ISO-8601-String oder None.
    Beispiele:
      "2024. szeptember 2., 14:00"
      "2024. 09 02., 14:00"
    """
    if not date_text:
        return None
    t = re.sub(r"\s+", " ", date_text).replace(" ,", ",").strip()
    logging.debug(f"Attempting to parse date: {t!r}")

    # Variante mit Monatsname (ungarisch)
    m = re.search(
        r"(?P<y>\d{4})\.\s*(?P<mon_name>[a-záéíóöőúüű]+)\s*(?P<d>\d{1,2})\.{0,2}\s*(?:,?\s*\w+)?\s*(?P<h>\d{1,2}):(?P<m>\d{2})",
        t, re.IGNORECASE
    )
    if m:
        y = int(m.group("y"))
        mon_name = m.group("mon_name").lower()
        d = int(m.group("d"))
        h = int(m.group("h"))
        mi = int(m.group("m"))
        mon = MONTH_MAP.get(mon_name)
        if not mon:
            return None
        try:
            dt = datetime(y, int(mon), d, h, mi)
            logging.debug(f"Parsed show_date: {dt}")
            return dt.isoformat()
        except ValueError:
            return None

    # Variante mit numerischem Monat
    m = re.search(
        r"(?P<y>\d{4})\.\s*(?P<mon>\d{1,2})\s+(?P<d>\d{1,2})\.{0,2}\s*(?:,?\s*\w+)?\s*(?P<h>\d{1,2}):(?P<m>\d{2})",
        t
    )
    if m:
        y = int(m.group("y"))
        mon = int(m.group("mon"))
        d = int(m.group("d"))
        h = int(m.group("h"))
        mi = int(m.group("m"))
        try:
            dt = datetime(y, mon, d, h, mi)
            logging.debug(f"Parsed show_date: {dt}")
            return dt.isoformat()
        except ValueError:
            return None

    logging.debug(f"Unparsed date text: {date_text!r}")
    return None


# ---------------- Hosts-Parsing ----------------
def _split_concat_names(raw: str) -> List[str]:
    """
    Teilt zusammengeklebte Namen (z.B. 'Hardy MihályBódy Gergő') heuristisch.
    - Trennt vor Großbuchstaben
    - Entfernt Trennzeichen
    """
    fixed = re.sub(r"(?<=[A-Za-zÁÉÍÓÖŐÚÜŰáéíóöőúüű])(?=[A-ZÁÉÍÓÖŐÚÜŰ])", "|", raw)
    parts = [p.strip(" ,;·•|") for p in fixed.split("|") if p.strip(" ,;·•|")]
    return parts


def _collect_host_texts(start: Tag) -> List[str]:
    """
    Sammelt Host-Namen ab dem H5-Label 'Műsorvezető' bis zum nächsten H5.
    Berücksichtigt <a>-Links, Kommas, Newlines, Listenpunkte, etc.
    """
    names: List[str] = []
    cur = start.find_next_sibling()
    while isinstance(cur, Tag) and cur.name != "h5":
        anchors = cur.find_all("a")
        if anchors:
            for a in anchors:
                txt = a.get_text(separator=" ", strip=True)
                if txt:
                    names.append(txt)
        else:
            raw = cur.get_text("\n", strip=True)
            if raw:
                prelim = re.split(r",|\bes\b|\n|·|•|;", raw)
                for p in prelim:
                    p = re.sub(r"^M[űu]sorvezet[őo]:?\s*", "", p.strip(), flags=re.IGNORECASE)
                    if not p:
                        continue
                    names.extend(_split_concat_names(p))
        cur = cur.find_next_sibling()

    # Deduplizieren, Reihenfolge erhalten
    out: List[str] = []
    seen = set()
    for n in names:
        if n and n not in seen:
            out.append(n)
            seen.add(n)
    return out


# ---------------- Archivseite ----------------
def parse_archive_page(html: str) -> List[Dict[str, Any]]:
    """
    Extrahiert Shows aus der Archivseite.
    Liefert List[dict] mit:
      title, hosts, description, detail_url, show_date(ISO)
    """
    soup = BeautifulSoup(html, "lxml")
    articles = soup.find_all('article', class_='program')
    logging.info(f"Found {len(articles)} article.program elements.")
    shows: list[dict] = []

    for article in articles:
        a = article.select_one('h4 a')
        title_strong = article.select_one('h3 a strong')
        lead = article.select_one('div.lead')

        title = title_strong.get_text(strip=True) if title_strong else (a.get_text(strip=True) if a else "")
        detail_href = a.get("href") if a else ""
        detail_url = f"{settings.KLUBRADIO_URL}{detail_href}" if detail_href else ""
        date_text = a.get_text(strip=True) if a else ""
        show_date_iso = parse_hu_date(date_text)

        hosts: List[str] = []
        h5 = article.find('h5')
        if h5 and "Műsorvezet" in h5.get_text():
            hosts = _collect_host_texts(h5)

        shows.append({
            "title": title,
            "hosts": hosts,
            "description": lead.get_text(separator=" ", strip=True) if lead else "",
            "detail_url": detail_url,
            "show_date": show_date_iso,
        })

    # Nur Einträge mit Detail-URL
    return [s for s in shows if s.get("detail_url")]


# ---------------- Detailseite ----------------
MP3_ATTR_CANDIDATES: tuple[str, ...] = ("data-url", "data-file", "data-audio", "data-src", "src", "href")


def _find_mp3_candidates(soup: BeautifulSoup, page_url: str, html: str) -> List[str]:
    """
    Sucht MP3-Links in Attributen, <audio>/<source> und als Roh-URL im HTML.
    Normalisiert zu absoluten URLs, dedupliziert.
    """
    cand: List[str] = []

    # Beliebige Attribute durchsuchen
    for el in soup.find_all(True):
        for attr in MP3_ATTR_CANDIDATES:
            if attr in el.attrs:
                val = el.get(attr)
                if isinstance(val, list):
                    for v in val:
                        if isinstance(v, str) and ".mp3" in v:
                            cand.append(v)
                elif isinstance(val, str) and ".mp3" in val:
                    cand.append(val)

    # <audio src> und <audio><source src>
    for src in soup.select("audio[src], audio source[src]"):
        v = src.get("src")
        if v and ".mp3" in v:
            cand.append(v)

    # Fallback: rohe URLs im HTML-Text
    for m in re.finditer(r"https?://[^\s\"'<>]+\.mp3(?:\?[^ \t\r\n\"'<>]*)?", html):
        cand.append(m.group(0))

    # Normalisieren + deduplizieren
    norm: List[str] = []
    for u in cand:
        u2 = urljoin(page_url, u).replace("&amp;", "&")
        if u2 not in norm:
            norm.append(u2)

    logging.debug(f"MP3 candidates found ({len(norm)}): {norm[:5]}{' ...' if len(norm) > 5 else ''}")
    return norm


def parse_detail_page(html: str, page_url: str) -> Dict[str, Any]:
    """
    Extrahiert von der Detailseite:
      - description (erster längerer Absatz)
      - hosts (wie beim Archiv, falls vorhanden)
      - mp3_url (erster gefundener Kandidat)
    """
    soup = BeautifulSoup(html, "lxml")

    # Beschreibung: erster längerer Absatz im Content-Bereich
    description: str | None = None
    for p in soup.select("div.col-md-8 p"):
        txt = p.get_text(separator=" ", strip=True)
        if txt and len(txt) > 40:
            description = txt
            break

    # Hosts wieder ab H5 sammeln
    hosts: List[str] = []
    h5 = soup.find(lambda tag: isinstance(tag, Tag) and tag.name == "h5" and "Műsorvezet" in tag.get_text())
    if h5:
        hosts = _collect_host_texts(h5)

    # MP3-Kandidaten suchen
    candidates = _find_mp3_candidates(soup, page_url, html)
    mp3_url = candidates[0] if candidates else None

    return {
        "mp3_url": mp3_url,
        "description": description,
        "hosts": hosts
    }
