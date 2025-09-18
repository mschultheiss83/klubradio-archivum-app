from __future__ import annotations
import logging
from .logging_setup import setup_logging
import re
from datetime import datetime
from typing import Any, Dict, List, Optional
from urllib.parse import urljoin

from bs4 import BeautifulSoup, Tag


# Ungarische Monatsnamen → Monat-Nummer
MONTH_MAP: dict[str, str] = {
    'január': '01', 'február': '02', 'március': '03', 'április': '04',
    'május': '05', 'június': '06', 'július': '07', 'augusztus': '08',
    'szeptember': '09', 'október': '10', 'november': '11', 'december': '12'
}
setup_logging(debug_mode=True, file_name="debug.parsing.log")


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


def _collect_host_texts(tag: Tag) -> List[str]:
    """
    Sammelt nur die Texte von Moderatoren und Gästen und entfernt
    die thematischen Beschreibungen.
    """
    hosts_text: List[str] = []

    # Gehen wir alle <p>-Tags im relevanten Bereich durch
    for p_tag in tag.select("p"):
        p_text = p_tag.get_text(strip=True)

        # Leere Zeilen ignorieren
        if not p_text:
            continue

        # Suchen nach dem ersten Trennzeichen, das den Namen/Titel vom Thema trennt.
        # Wir prüfen auf Bindestrich (–) oder Doppelpunkt (:).
        if "–" in p_text:
            parts = p_text.split("–", 1)
            hosts_text.append(parts[0].strip())
        elif ":" in p_text:
            parts = p_text.split(":", 1)
            # Nur hinzufügen, wenn der Teil vor dem Doppelpunkt sinnvoll ist (z.B. nicht nur eine Jahreszahl)
            if len(parts[0]) > 4:
                hosts_text.append(parts[0].strip())
        else:
            # Für Fälle ohne Trennzeichen (z.B. nur ein Name), die ganze Zeile hinzufügen
            hosts_text.append(p_text.strip())

    # Wir bereinigen die Liste von unerwünschten Elementen wie YouTube-Links oder leeren Zeilen.
    # Dies ist eine weitere Heuristik, um die Daten zu säubern.
    cleaned_hosts = [
        item for item in hosts_text
        if "YouTube" not in item and "podcast" not in item and "Spotify" not in item
    ]

    # Entferne Duplikate
    unique_hosts = list(dict.fromkeys(cleaned_hosts))

    return unique_hosts


# ---------------- Archivseite ----------------
def parse_archive_page(html: str, page_url: str) -> List[Dict[str, Any]]:
    """
    Parst die Archivseite und extrahiert die Sendungen mit Metadaten.
    """
    soup = BeautifulSoup(html, "lxml")
    shows: List[Dict[str, Any]] = []
    articles = soup.find_all('article', class_='program')
    logging.info(f"Found {len(articles)} article.program elements.")

    for li in articles:
        show = {}
        link_tag = li.select_one("h3 a")
        logging.info(f"Attempting to parse link_tag: {link_tag}")
        if not link_tag:
            continue

        # Titel extrahieren und das Datum-Span sicher entfernen
        full_title_text = link_tag.get_text()
        date_start_index = full_title_text.find("(")

        if date_start_index != -1:
            # Den Titel am ersten '(' aufteilen
            show_title = full_title_text[:date_start_index].strip()
            date_text = full_title_text[date_start_index + 1:].strip().rstrip(')')
            show_date = parse_hu_date(date_text)
            show["title"] = show_title
            show["show_date"] = show_date if len(show_date) else date_text
        else:
            # Fallback, wenn kein Datum in Klammern gefunden wird
            show["title"] = full_title_text
            show["show_date"] = None

        show["detail_url"] = urljoin(page_url, link_tag["href"])

        desc_tag = li.select_one("div.show-desc p")
        if desc_tag:
            show["description"] = desc_tag.get_text(strip=True)

        host_list = _collect_host_texts(li)
        show["hosts"] = host_list

        shows.append(show)

    return shows


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
