from __future__ import annotations
from typing import List, Dict
from datetime import datetime, timezone
from feedgen.feed import FeedGenerator  # standard feedgen
from .config import settings
import os


def _maybe_itunes(fe, hosts: list[str], desc: str, duration: int | None):
    """
    Setzt iTunes-Felder nur, wenn die feedgen-Installation das Feature anbietet.
    Optional via ENV `ENABLE_ITUNES_TAGS=1` erzwingbar.
    """
    want = os.getenv("ENABLE_ITUNES_TAGS", "1")  # default anlassen, aber fallbacksicher
    if want not in ("1", "true", "TRUE", "yes", "on"):
        return
    try:
        podcast = getattr(fe, "podcast", None)
        if not podcast:
            return
        if hosts:
            podcast.itunes_author(", ".join(hosts))
        podcast.itunes_summary(desc)
        if isinstance(duration, int) and duration > 0:
            podcast.itunes_duration(duration)
    except Exception:
        # Auf Windows/Umgebungen ohne Podcast-Erweiterung einfach still weiter
        pass


def generate_rss_feed(shows: List[Dict]) -> str:
    fg = FeedGenerator()
    fg.id(settings.KLUBRADIO_ARCHIVE_URL)
    fg.title("Klubrádió Archive")
    fg.author({"name": "Klubrádió", "email": "info@klubradio.hu"})
    fg.link(href=settings.KLUBRADIO_ARCHIVE_URL, rel="alternate")
    fg.logo("https://www.klubradio.hu/images/logo.png")
    fg.subtitle("Archived shows from Klubrádió, available as podcasts.")
    fg.link(href="https://example.invalid/storage/rss/klubradio_archive.xml", rel="self")
    fg.language("hu")

    for show in shows:
        mp3 = show.get("mp3_url")
        if not mp3:
            continue

        fe = fg.add_entry()
        fe.id(mp3)
        fe.title(show.get("title") or "Klubrádió")
        fe.link(href=show.get("detail_url") or settings.KLUBRADIO_ARCHIVE_URL, rel="alternate")

        desc = (show.get("description") or show.get("title") or "").strip()
        fe.description(desc)

        duration = show.get("duration")
        fe.enclosure(url=mp3, length=str(duration * 1000 if duration else 0), type="audio/mpeg")

        pub_iso = show.get("show_date")
        try:
            dt = datetime.fromisoformat(pub_iso) if pub_iso else datetime.now(timezone.utc)
            if dt.tzinfo is None:
                dt = dt.replace(tzinfo=timezone.utc)
            fe.pubDate(dt)
        except Exception:
            fe.pubDate(datetime.now(timezone.utc))

        hosts = show.get("hosts") or []
        _maybe_itunes(fe, hosts, desc, duration)

    return fg.rss_str(pretty=True).decode("utf-8")
