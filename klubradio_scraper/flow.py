from __future__ import annotations

import hashlib
import logging
from typing import Any, Dict, List, Optional

from .cache import get as cache_get
from .cache import set as cache_set
from .config import settings
from .logging_setup import setup_logging
from .mp3meta import get_mp3_duration
from .net import fetch_page, make_session
from .parsing import parse_archive_page, parse_detail_page
from .rss_build import generate_rss_feed
from .supa import SupaLike


def _h(s: Any) -> str:
    """
    Stabiles SHA1 über beliebige Eingaben für Dateinamen etc.
    """
    if isinstance(s, bytes):
        b = s
    else:
        b = str(s).encode("utf-8", "ignore")
    return hashlib.sha1(b).hexdigest()


def non_destructive_merge(a: Dict[str, Any], b: Dict[str, Any]) -> Dict[str, Any]:
    """
    Merged b in a, aber nur 'wertige' Werte (nicht None/leer).
    """
    out = dict(a)
    for k, v in b.items():
        if v is None:
            continue
        if isinstance(v, str) and not v.strip():
            continue
        if isinstance(v, (list, dict)) and not v:
            continue
        out[k] = v
    return out


def get_archive_shows(session, use_cache: bool = True) -> List[Dict[str, Any]]:
    """
    Lädt die Archivseite, parst Shows, cached Ergebnis + HTML.
    """
    key = "archive"
    if use_cache:
        c = cache_get("archive", key, settings.TTL_ARCHIVE)
        if c:
            logging.info(f"Using cached archive list ({len(c)} shows).")
            return c

    html = fetch_page(
        session,
        settings.KLUBRADIO_ARCHIVE_URL,
        save_html=settings.SAVE_HTML,
        filename=settings.LOG_DIR / "klubradio_archive_page.html",
    )
    if not html:
        return []

    shows = parse_archive_page(html=html, page_url=settings.KLUBRADIO_URL)
    cache_set("archive", key, shows, html=html)
    return shows


def get_detail_for_show(session, detail_url: str, use_cache: bool = True) -> Dict[str, Any]:
    """
    Lädt Detailseite einer Show, parst Metadaten, cached Ergebnis + HTML.
    """
    if use_cache:
        c = cache_get("detail", detail_url, settings.TTL_DETAIL)
        if c:
            return c

    safe = _h(detail_url)[:12]
    html = fetch_page(
        session,
        detail_url,
        save_html=settings.SAVE_HTML,
        filename=settings.LOG_DIR / f"klubradio_detail_page_{safe}.html",
    )
    if not html:
        return {}

    data = parse_detail_page(html, page_url=detail_url)
    cache_set("detail", detail_url, data, html=html)
    return data


def run(supa_client=None, use_cache: bool = True) -> Optional[str]:
    """
    End-to-end Lauf:
      1) Archiv parsen
      2) Details + MP3-Dauer anreichern
      3) (optional) Supabase upsert
      4) RSS generieren (+ optional hochladen)
    Gibt RSS-XML zurück oder None.
    """
    setup_logging()
    session = make_session()
    supa = SupaLike(supa_client)

    shows = get_archive_shows(session, use_cache=use_cache)
    enriched: List[Dict[str, Any]] = []

    for s in shows:
        logging.info(f"Processing: {s.get('title')} - {s.get('detail_url')}")
        if not s.get("detail_url"):
            logging.warning("Skipping show without detail_url.")
            continue

        d = get_detail_for_show(session, s["detail_url"], use_cache=use_cache)
        merged = non_destructive_merge(s, d)

        if not merged.get("mp3_url"):
            logging.warning(f"Skipping show due to missing MP3 URL: {merged.get('title')}")
            continue

        # MP3-Dauer bestimmen (mit eigenem Cache)
        merged["duration"] = get_mp3_duration(session, merged["mp3_url"])

        # Optional: Persistenz
        supa.upsert_show(merged)
        enriched.append(merged)

    # Datenbasis für RSS: bevorzugt DB, sonst die angereicherten Laufdaten
    data_for_rss = supa.fetch_all_shows() or enriched
    if not data_for_rss:
        logging.warning("No shows to publish in RSS (no MP3 URLs found).")
        return None

    rss_xml = generate_rss_feed(data_for_rss)
    supa.upload_rss_to_storage(rss_xml)
    return rss_xml
