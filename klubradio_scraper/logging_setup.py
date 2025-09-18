import logging

from .config import settings


def setup_logging(level=logging.INFO):
    logging.basicConfig(
        level=level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.FileHandler(settings.LOG_DIR / "debug.log", encoding="utf-8"),
            logging.StreamHandler()
        ],
    )
    return logging.getLogger(__name__)
