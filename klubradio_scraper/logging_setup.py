import logging
import sys
from pathlib import Path
from .config import settings


def setup_logging(debug_mode: bool = False, file_name: str = "debug.log"):
    """
    Konfiguriert das Logging-System.
    """
    log_file_path = settings.LOG_DIR / file_name
    handlers = [
        logging.StreamHandler(sys.stdout),
        logging.FileHandler(log_file_path, mode='w', encoding='utf-8')
    ]

    logging.basicConfig(
        level=logging.DEBUG if debug_mode else logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=handlers
    )
    return logging.getLogger(__name__)
