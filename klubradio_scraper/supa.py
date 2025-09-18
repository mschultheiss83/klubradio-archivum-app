from __future__ import annotations

import logging
from typing import Any, Dict, List, Optional

from supabase import Client, create_client  # type: ignore

from .config import settings


class Supa:
    """
    Echte Supabase-Integration mit Auto-Bucket-Anlage.
    Nutzt ENV: SUPABASE_URL, SUPABASE_SERVICE_KEY, Bucket aus settings.
    """
    def __init__(self) -> None:
        if not settings.SUPABASE_URL or not settings.SUPABASE_SERVICE_KEY:
            raise RuntimeError("Supabase URL/Service Key fehlt (SUPABASE_URL / SUPABASE_SERVICE_KEY)")
        self.client: Client = create_client(settings.SUPABASE_URL, settings.SUPABASE_SERVICE_KEY)
        self._ensure_bucket(settings.SUPABASE_STORAGE_BUCKET)

    def _ensure_bucket(self, bucket: str, public: bool = True) -> None:
        """
        Legt Bucket an, wenn nicht vorhanden. Idempotent.
        """
        try:
            buckets = self.client.storage.list_buckets()
            if any(b.get("name") == bucket for b in buckets):  # type: ignore[truthy-bool]
                return
        except Exception as e:
            logging.warning(f"Konnte Buckets nicht auflisten (ignoriert): {e}")

        try:
            self.client.storage.create_bucket(bucket, public=public)
            logging.info(f"Bucket '{bucket}' angelegt (public={public}).")
        except Exception as e:
            msg = str(e)
            if "already exists" in msg or "Bucket already exists" in msg or "409" in msg:
                logging.info(f"Bucket '{bucket}' existiert bereits.")
            else:
                logging.error(f"Bucket-Anlage fehlgeschlagen: {e}")

    def upload_rss_to_storage(self, rss_content: str, filename: str = "klubradio_archive.xml") -> None:
        try:
            self.client.storage.from_(settings.SUPABASE_STORAGE_BUCKET).upload(
                path=filename,
                file=rss_content.encode("utf-8"),
                file_options={"content-type": "application/xml", "upsert": "true"},
            )
            logging.info(
                f"Uploaded RSS to storage as {filename} in bucket '{settings.SUPABASE_STORAGE_BUCKET}'"
            )
        except Exception as e:
            logging.error(f"RSS upload failed: {e}")

    def upsert_show(self, show: Dict[str, Any]) -> None:
        if not show.get("mp3_url"):
            logging.info(f"Skipping upsert (no mp3): {show.get('title')}")
            return
        try:
            (
                self.client.table("shows")
                .upsert(show, on_conflict="mp3_url")
                .execute()
            )
            logging.debug(f"Upserted show: {show.get('title')}")
        except Exception as e:
            logging.error(f"Upsert failed for {show.get('title')}: {e}")

    def fetch_all_shows(self) -> List[Dict[str, Any]]:
        try:
            resp = self.client.table("shows").select("*").execute()
            return resp.data if getattr(resp, "data", None) is not None else []
        except Exception as e:
            logging.error(f"Supabase fetch failed: {e}")
            return []


class SupaLike:
    """
    Test-/Flow-freundlicher Wrapper:
    - Akzeptiert einen Supabase-Client (kann None sein).
    - Methoden sind No-ops, wenn kein Client vorhanden ist.
    """
    def __init__(self, client: Optional[Client] = None):
        self.client = client

    def upload_rss_to_storage(self, rss_content: str, filename: str = "klubradio_archive.xml") -> None:
        if not self.client:
            logging.info("No Supabase client provided. Skipping upload.")
            return
        try:
            self.client.storage.from_(settings.SUPABASE_STORAGE_BUCKET).upload(
                path=filename,
                file=rss_content.encode("utf-8"),
                file_options={"content-type": "application/xml", "upsert": "true"},
            )
            logging.info(f"Uploaded RSS to storage as {filename}")
        except Exception as e:
            logging.error(f"RSS upload failed: {e}")

    def upsert_show(self, show: Dict[str, Any]) -> None:
        if not self.client:
            logging.info("No Supabase client provided. Skipping upsert.")
            return
        if not show.get("mp3_url"):
            logging.info(f"Skipping upsert (no mp3): {show.get('title')}")
            return
        try:
            (
                self.client.table("shows")
                .upsert(show, on_conflict="mp3_url")
                .execute()
            )
            logging.debug(f"Upserted show: {show.get('title')}")
        except Exception as e:
            logging.error(f"Upsert failed for {show.get('title')}: {e}")

    def fetch_all_shows(self) -> List[Dict[str, Any]]:
        if not self.client:
            return []
        try:
            resp = self.client.table("shows").select("*").execute()
            return resp.data if getattr(resp, "data", None) is not None else []
        except Exception as e:
            logging.error(f"Supabase fetch failed: {e}")
            return []
