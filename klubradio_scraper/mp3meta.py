from __future__ import annotations

import logging
from io import BytesIO
from typing import Optional

import requests
from mutagen.mp3 import MP3  # type: ignore

from .cache import get as cache_get
from .cache import set as cache_set
from .config import settings


def get_mp3_duration(session: requests.Session, mp3_url: str) -> Optional[int]:
    """
    Ermittelt die MP3-Dauer in Sekunden.
    - Nutzt Cache ("mp3"-Namespace), um Requests zu sparen.
    - Holt nur die ersten ~200 KB (HTTP Range), ausreichend für die meisten MP3-Header.
    - Gibt None zurück, wenn kein Header/Fehler.
    """
    if not mp3_url:
        return None

    # Cache-Hit?
    cached = cache_get("mp3", mp3_url, settings.TTL_MP3)
    if isinstance(cached, dict) and "duration" in cached:
        return cached["duration"]

    try:
        headers = {"Range": "bytes=0-204800"}
        r = session.get(mp3_url, headers=headers, stream=True, timeout=20)
        r.raise_for_status()

        audio_file = BytesIO(r.content)
        audio = MP3(audio_file)  # type: ignore

        dur = None
        if getattr(audio, "info", None) is not None and getattr(audio.info, "length", None) is not None:
            dur = int(audio.info.length)  # type: ignore[attr-defined]

        # Im Cache ablegen (auch wenn dur=None, um erneutes Pollen zu vermeiden)
        cache_set("mp3", mp3_url, {"duration": dur})
        return dur

    except Exception as e:
        logging.warning(f"MP3 duration error for {mp3_url}: {e}")
        return None
