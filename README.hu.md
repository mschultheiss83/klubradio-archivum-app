# 🇭🇺 Magyar

## Mit tartalmaz
- `klubradio_scraper/` – parser, cache, net (rate limit), RSS, Supabase, flow
- `tests/` – unit + integrációs tesztek
- `.github/workflows/ci.yml` – GitHub Actions
- `docs/` – [LEGAL.md](docs/LEGAL.md) (HU/EN/DE/ES)

## Gyors indítás (fejlesztéshez)
```bash
python -m venv .venv && . .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
pip install -e .
pytest -q
ruff check .
````

Offline próba:

```bash
python -m klubradio_scraper --offline --upload
```

## Konfiguráció

`.env`:

```
SUPABASE_URL=...
SUPABASE_SERVICE_KEY=...
SUPABASE_STORAGE_BUCKET=public
```
