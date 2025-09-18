import time
from klubradio_scraper.net import make_session


def test_rate_limiting_enforces_delay(monkeypatch):
    session = make_session(rate_per_sec=2.0)  # max 2 req/s → min 0.5s Abstand
    times = []

    # Fake transport: keine echten HTTP-Requests
    def fake_request(self, method, url, *args, **kwargs):
        times.append(time.monotonic())
        class Dummy:
            status_code = 200
            text = "ok"
        return Dummy()

    monkeypatch.setattr("requests.Session.request", fake_request)

    for _ in range(3):
        session.get("http://example.org")

    # Drei Requests → sollten ~1s Minimum benötigen
    total_elapsed = times[-1] - times[0]
    assert total_elapsed >= 1.0, f"Rate limiting failed, took only {total_elapsed:.3f}s"
