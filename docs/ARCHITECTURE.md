# Architektur Klubradio Archiv App

## Übersicht
- **Scraper (Python)**: Holt HTML vom Klubradio-Archiv, parst Shows, extrahiert MP3s.
- **Cache**: JSON + HTML-Sidecar im `cache/`.
- **Supabase**: Speicherung der Shows, RSS-Upload ins Storage.
- **Rate Limiting**: Alle Requests laufen über `RateLimitedSession` (Standard 2 req/s pro Host).
- **CI**: GitHub Actions (Lint, Tests, Live-Supabase-Upload).
