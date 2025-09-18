from datetime import timedelta
import hashlib
from klubradio_scraper import cache as cache_mod


def test_cache_roundtrip(tmp_path):
    """
    Testet den JSON/HTML-Cache, ohne das (frozen) Settings-Objekt zu verändern.
    Wir patchen stattdessen die Pfadfunktionen lokal auf tmp_path um.
    """
    # Originale sichern
    orig_json_path = cache_mod.json_path
    orig_html_path = cache_mod.html_path

    def _h(s: str) -> str:
        return hashlib.sha1(s.encode("utf-8")).hexdigest()

    try:
        def json_path(prefix: str, key):
            return tmp_path / f"{prefix}-{_h(str(key))}.json"

        def html_path(prefix: str, key):
            return tmp_path / f"{prefix}-{_h(str(key))}.html"

        cache_mod.json_path = json_path  # monkeypatch durch direkte Zuweisung
        cache_mod.html_path = html_path

        key = "unit-test"
        cache_mod.set("unit", key, {"x": 1}, html="<p>ok</p>")
        data = cache_mod.get("unit", key, timedelta(days=1))
        assert data == {"x": 1}
        assert (tmp_path / f"unit-{_h(key)}.html").exists()
    finally:
        # Restore
        cache_mod.json_path = orig_json_path
        cache_mod.html_path = orig_html_path
