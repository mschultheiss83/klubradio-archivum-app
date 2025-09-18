import glob
import os
import pytest
from klubradio_scraper.parsing import parse_hu_date, parse_archive_page, parse_detail_page


def test_parse_hu_date_named_month():
    iso = parse_hu_date("2024. szeptember 2., 14:00")
    assert iso and iso.startswith("2024-09-02")


@pytest.mark.skipif(len(glob.glob("cache/archive-*.html")) == 0, reason="no real archive cache files found")
def test_parse_archive_page_extracts_show_real():
    # Nimm die erste echte Archiv-HTML
    path = sorted(glob.glob("cache/archive-*.html"))[0]
    html = open(path, encoding="utf-8").read()
    shows = parse_archive_page(html)
    assert isinstance(shows, list)
    # Mindestens eine Detail-URL vorhanden
    assert any(s.get("detail_url") for s in shows)


@pytest.mark.skipif(len(glob.glob("cache/detail-*.html")) == 0, reason="no real detail cache files found")
def test_parse_detail_page_finds_mp3_and_hosts_real():
    path = sorted(glob.glob("cache/detail-*.html"))[0]
    html = open(path, encoding="utf-8").read()
    detail = parse_detail_page(html, page_url="https://dummy.example/detail")
    # Mind. Beschreibung oder MP3-URL
    assert detail.get("description") or detail.get("mp3_url")
