import glob
import pytest
from klubradio_scraper.parsing import parse_archive_page, parse_detail_page


@pytest.mark.parametrize("path", glob.glob("cache/archive-*.html"))
def test_parse_real_archive(path):
    html = open(path, encoding="utf-8").read()
    shows = parse_archive_page(html)
    assert isinstance(shows, list)
    assert any(s.get("detail_url") for s in shows), f"No detail_url found in {path}"


@pytest.mark.parametrize("path", glob.glob("cache/detail-*.html"))
def test_parse_real_detail(path):
    html = open(path, encoding="utf-8").read()
    detail = parse_detail_page(html, page_url="https://dummy.example/detail")
    assert detail.get("description") or detail.get("mp3_url"), f"No description/mp3_url in {path}"
