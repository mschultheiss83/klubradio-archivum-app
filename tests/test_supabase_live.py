import os
import pytest
from datetime import datetime, timezone
from klubradio_scraper.rss_build import generate_rss_feed
from klubradio_scraper.supa import Supa

SECRETS_PRESENT = bool(os.getenv("SUPABASE_URL")) and bool(os.getenv("SUPABASE_SERVICE_KEY"))

pytestmark = pytest.mark.skipif(not SECRETS_PRESENT, reason="SUPABASE_* secrets not set")


def test_supabase_rss_upload_smoke():
    # Minimaldaten für einen lauffähigen RSS-Feed (ohne echte Scrape-Abhängigkeit)
    shows = [{
        "title": "CI Sanity Check",
        "detail_url": "https://example.org/detail",
        "mp3_url": "https://example.org/audio/test.mp3",
        "description": "Automated CI upload test.",
        "show_date": datetime.now(timezone.utc).isoformat(),
        "hosts": ["CI Runner"],
        "duration": 42,
    }]

    rss_xml = generate_rss_feed(shows)
    assert "<rss" in rss_xml.lower()

    supa = Supa()
    # Eindeutiger Pfad im Bucket, damit nichts überschrieben wird
    filename = f"ci/klubradio_{os.getenv('GITHUB_RUN_ID','local')}.xml"
    supa.upload_rss_to_storage(rss_xml, filename=filename)

    # Wenn keine Exception geflogen ist, betrachten wir den Upload als ok
    assert True
