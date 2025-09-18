# 🇬🇧 & 🇺🇸 English

## What’s inside
- `klubradio_scraper/` – parser, cache, net (rate-limited), RSS builder, Supabase, flow
- `tests/` – unit & integration tests
- `.github/workflows/ci.yml` – GitHub Actions
- `docs/` – [LEGAL.md](docs/LEGAL.md) (HU/EN/DE/ES), architecture

## Quick start (local dev)
```bash
python -m venv .venv && . .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
pip install -e .
pytest -q
ruff check .
````

Offline smoke:

```bash
python -m klubradio_scraper --offline --upload
```

## Configuration

`.env` file:

```
SUPABASE_URL=...
SUPABASE_SERVICE_KEY=...
SUPABASE_STORAGE_BUCKET=public
```

## CI

* Lint + tests always
* Supabase smoke test only on `main` if secrets are set

