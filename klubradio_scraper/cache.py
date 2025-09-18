from __future__ import annotations

import hashlib
import json
import logging
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Optional

from .config import settings


# --- Helpers ---------------------------------------------------------------
def _to_bytes(x: Any) -> bytes:
    """
    Normalisiert Eingaben zu bytes:
    - bytes -> unverändert
    - str   -> utf-8
    - sonst -> str(x).encode('utf-8', 'ignore')
    """
    if isinstance(x, bytes):
        return x
    if isinstance(x, str):
        return x.encode("utf-8", "ignore")
    return str(x).encode("utf-8", "ignore")


def _h(key: Any) -> str:
    """SHA1-Hexdigest über einen beliebigen Key (str/bytes/Any)."""
    return hashlib.sha1(_to_bytes(key)).hexdigest()


def _safe_stem(prefix: str, key: Any) -> str:
    """Baut einen sicheren Dateinamen-Stem 'prefix-<sha1>'."""
    return f"{prefix}-{_h(key)}"


# --- Pfade -----------------------------------------------------------------
def json_path(prefix: str, key: Any) -> Path:
    """Pfad zur JSON-Cache-Datei."""
    return settings.CACHE_DIR / f"{_safe_stem(prefix, key)}.json"


def html_path(prefix: str, key: Any) -> Path:
    """Pfad zur optionalen HTML-Sidecar-Datei."""
    return settings.CACHE_DIR / f"{_safe_stem(prefix, key)}.html"


# --- API -------------------------------------------------------------------
def get(prefix: str, key: Any, max_age: timedelta):
    """
    Liest JSON aus dem Cache, wenn vorhanden & nicht abgelaufen.
    Gibt dict/list/etc. oder None zurück.
    """
    p = json_path(prefix, key)
    if not p.exists():
        return None
    try:
        age = datetime.now(timezone.utc) - datetime.fromtimestamp(p.stat().st_mtime, tz=timezone.utc)
        if age > max_age:
            logging.debug(f"Cache expired for {p} (age {age}, ttl {max_age})")
            return None
        with p.open("r", encoding="utf-8") as f:
            data = json.load(f)
        logging.debug(f"Cache hit for {p}")
        return data
    except Exception as e:
        logging.warning(f"cache.get error for {p}: {e}")
        return None


def set(prefix: str, key: Any, data: Any, html: Optional[str] = None):
    """
    Schreibt JSON in den Cache. Optional auch HTML-Sidecar.
    """
    p = json_path(prefix, key)
    try:
        p.parent.mkdir(parents=True, exist_ok=True)
        with p.open("w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        logging.debug(f"Cache set for {p}")
    except Exception as e:
        logging.warning(f"cache.set error for {p}: {e}")

    if settings.CACHE_HTML and html:
        hp = html_path(prefix, key)
        try:
            hp.parent.mkdir(parents=True, exist_ok=True)
            hp.write_text(html, encoding="utf-8")
            logging.debug(f"HTML cached at {hp}")
        except Exception as e:
            logging.warning(f"cache.set(HTML) error for {hp}: {e}")
