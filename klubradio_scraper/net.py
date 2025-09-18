from __future__ import annotations

import logging
import threading
import time
from importlib.metadata import PackageNotFoundError, version
from pathlib import Path
from typing import Optional
from urllib.parse import urlparse

import requests


class RateLimitedSession(requests.Session):
    """
    Requests-Session mit Rate-Limitierung pro Host.
    Default: max. 2 Requests / Sekunde je Host (min. 0.5s Abstand).
    Thread-safe.
    """
    def __init__(self, rate_per_sec: float = 2.0):
        super().__init__()
        if rate_per_sec <= 0:
            # Fallback: sehr konservativ
            rate_per_sec = 1.0
        self._lock = threading.Lock()
        self._last_request_time: dict[str, float] = {}
        self._min_interval = 1.0 / rate_per_sec

    def request(self, method, url, *args, **kwargs):
        host = urlparse(url).netloc or "default"
        with self._lock:
            last_time = self._last_request_time.get(host, 0.0)
            now = time.monotonic()
            elapsed = now - last_time
            wait = self._min_interval - elapsed
            if wait > 0:
                time.sleep(wait)
            self._last_request_time[host] = time.monotonic()
        return super().request(method, url, *args, **kwargs)


def _user_agent() -> str:
    """Baut den User-Agent inkl. Paketversion."""
    try:
        ver = version("klubradio-scraper")
    except PackageNotFoundError:
        ver = "0.0.0"
    return f"KlubradioScraper/{ver} (+https://github.com/yourorg/klubradio-archivum-app)"


def make_session(rate_per_sec: float = 2.0) -> RateLimitedSession:
    """
    Erzeugt eine requests.Session mit Rate-Limit und sauberem UA.
    """
    s = RateLimitedSession(rate_per_sec=rate_per_sec)
    s.headers.update({"User-Agent": _user_agent()})
    return s


def fetch_page(session: requests.Session, url: str, save_html: bool = False, filename: Optional[Path] = None) -> Optional[str]:
    """
    Holt HTML einer Seite. Optional speichert es eine Kopie auf Disk.
    Gibt den HTML-Text oder None bei Fehlern zurück.
    """
    try:
        logging.info(f"Fetching URL: {url}")
        r = session.get(url, timeout=20)
        r.raise_for_status()
        html = r.text
        if save_html and filename:
            try:
                filename.parent.mkdir(parents=True, exist_ok=True)
                filename.write_text(html, encoding="utf-8")
                logging.info(f"Saved HTML content to {filename}")
            except Exception as e:
                logging.warning(f"Failed to save HTML {filename}: {e}")
        return html
    except requests.RequestException as e:
        logging.error(f"Request error for {url}: {e}")
        return None
