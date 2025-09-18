import argparse
from datetime import datetime, timezone
from .flow import run
from .supa import Supa
from .rss_build import generate_rss_feed


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--offline", action="store_true", help="Run with dummy show instead of scraping")
    parser.add_argument("--upload", action="store_true", help="Upload to Supabase storage")
    args = parser.parse_args()

    if args.offline:
        shows = [{
            "title": "CI Offline Test",
            "detail_url": "https://example.org/detail",
            "mp3_url": "https://example.org/audio/test.mp3",
            "description": "Offline CI sanity check.",
            "show_date": datetime.now(timezone.utc).isoformat(),
            "hosts": ["CI Runner"],
            "duration": 99,
        }]
        rss_xml = generate_rss_feed(shows)
        if args.upload:
            supa = Supa()
            supa.upload_rss_to_storage(rss_xml, filename="ci/offline_test.xml")
        print(rss_xml[:200] + "...")
    else:
        supa = Supa()
        rss_xml = run(supa_client=supa.client, use_cache=True)
        if rss_xml:
            print("RSS generated.")
        else:
            print("No RSS generated.")


if __name__ == "__main__":
    main()

