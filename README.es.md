# 🇪🇸 Español

## Contenido
- `klubradio_scraper/` – parser, cache, net (rate limit), generador RSS, Supabase, flow
- `tests/` – pruebas unitarias e integrales
- `.github/workflows/ci.yml` – GitHub Actions
- `docs/` – [LEGAL.md](docs/LEGAL.md) (HU/EN/DE/ES)

## Inicio rápido (desarrollo local)
```bash
python -m venv .venv && . .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
pip install -e .
pytest -q
ruff check .
````

Prueba offline:

```bash
python -m klubradio_scraper --offline --upload
```

## Configuración

`.env`:

```
SUPABASE_URL=...
SUPABASE_SERVICE_KEY=...
SUPABASE_STORAGE_BUCKET=public
```