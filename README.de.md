# 🇩🇪 Deutsch

## Inhalt
- `klubradio_scraper/` – Parser, Cache, Net (Rate Limit), RSS, Supabase, Flow
- `tests/` – Unit- und Integrationstests
- `.github/workflows/ci.yml` – GitHub Actions
- `docs/` – [LEGAL.md](docs/LEGAL.md) (HU/EN/DE/ES)

## Quick start (lokale Entwicklung)
```bash
python -m venv .venv && . .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
pip install -e .
pytest -q
ruff check .
````

Offline-Test:

```bash
python -m klubradio_scraper --offline --upload
```

## Konfiguration

`.env` Datei:

```
SUPABASE_URL=...
SUPABASE_SERVICE_KEY=...
SUPABASE_STORAGE_BUCKET=public
```
