import os
from dataclasses import dataclass
from datetime import timedelta
from pathlib import Path

from dotenv import load_dotenv

load_dotenv()


@dataclass(frozen=True)
class Settings:
    BASE_DIR: Path = Path(".")
    LOG_DIR: Path = BASE_DIR / "logs"
    CACHE_DIR: Path = BASE_DIR / "cache"
    SAVE_HTML: bool = True
    CACHE_HTML: bool = True
    SUPABASE_URL: str = os.getenv("SUPABASE_URL", "")
    SUPABASE_SERVICE_KEY: str = os.getenv("SUPABASE_SERVICE_KEY", "")
    SUPABASE_STORAGE_BUCKET: str = "rss"
    KLUBRADIO_ARCHIVE_URL: str = "https://www.klubradio.hu/archivum"
    KLUBRADIO_URL: str = "https://www.klubradio.hu"
    TTL_ARCHIVE: timedelta = timedelta(hours=6)
    TTL_DETAIL: timedelta = timedelta(days=7)
    TTL_MP3: timedelta = timedelta(days=30)


settings = Settings()
settings.LOG_DIR.mkdir(parents=True, exist_ok=True)
settings.CACHE_DIR.mkdir(parents=True, exist_ok=True)
