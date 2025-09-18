from klubradio_scraper import flow

ARCHIVE_HTML = """
<html><body>
<article class="program">
  <h4><a href="/anyag/valami/123">2024. szeptember 2., 14:00</a></h4>
  <h3><a><strong>Műsor A</strong></a></h3>
  <div class="lead">Leírás szöveg...</div>
  <h5>Műsorvezető</h5>
  <p><a>Hardy Mihály</a>, <a>Bódy Gergő</a></p>
</article>
</body></html>
"""

DETAIL_HTML = """
<html><body>
<div class="col-md-8"><p>Ez egy hosszabb leírás, amely bőven meghaladja a negyven karaktert.</p></div>
<h5>Műsorvezető</h5>
<p>Hardy MihályBódy Gergő</p>
<a href="https://cdn.example.com/audio/file.mp3">Listen</a>
</body></html>
"""


def test_flow_end_to_end_without_db(monkeypatch):
    # Netzwerk stubben: Archiv → Detail
    def fake_fetch_page(session, url, save_html=False, filename=None):
        return ARCHIVE_HTML if "archivum" in url else DETAIL_HTML

    # MP3-Dauer stubben
    def fake_get_mp3_duration(session, mp3_url):
        return 1234

    # RSS-Bau stubben (um feedgen.podcast-Abhängigkeit zu vermeiden)
    def fake_generate_rss_feed(shows):
        return "<rss>ok</rss>"

    monkeypatch.setattr(flow, "fetch_page", fake_fetch_page, raising=True)
    monkeypatch.setattr(flow, "get_mp3_duration", fake_get_mp3_duration, raising=True)
    monkeypatch.setattr(flow, "generate_rss_feed", fake_generate_rss_feed, raising=True)

    # Supabase auslassen (flow nutzt SupaLike(None) → no-op)
    rss_xml = flow.run(supa_client=None, use_cache=False)

    assert rss_xml == "<rss>ok</rss>"
