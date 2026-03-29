# Web Platform Setup & Limitations

**Status:** Active
**Date:** 2026-03-29

## Deployment

- **URL:** `https://multilevelstudios.de/klubradio/`
- **Base href:** `--base-href /klubradio/` (set in `.github/workflows/deploy-web.yml`)
- **CI:** `Deploy Web App` workflow builds on push to `dev`

## Drift Database on Web (WASM)

The app uses drift with full WASM support on web. Two files in `web/` are
required and must be kept in sync with the drift version:

| File | Size | Purpose |
|------|------|---------|
| `web/sqlite3.wasm` | ~731 KB | SQLite3 compiled to WebAssembly |
| `web/drift_worker.js` | ~355 KB | Dart-compiled web worker for off-thread SQL |

These are loaded by `lib/db/connection/connection_web.dart` via
`WasmDatabase.open()`. The `<base href>` in `index.html` ensures the relative
URIs resolve correctly under `/klubradio/`.

**Updating WASM files after drift version bump:**
```bash
dart run drift_dev:generate_web_worker
# Then copy sqlite3.wasm from the dart package cache to web/
```

## Disabled Features on Web

Downloads, subscriptions, and offline cache are disabled via `PlatformUtils`
guards (`!kIsWeb`). The database exists on web but stays mostly empty — it
satisfies the provider dependency chain without functional impact.

| Feature | Guard |
|---------|-------|
| Downloads | `PlatformUtils.supportsDownloads` |
| Subscriptions | `PlatformUtils.supportsSubscriptions` |
| Offline cache (JSON/JPG/MP3) | Download service not initialized |
| Background audio | `PlatformUtils.supportsBackgroundAudio` |

## What Works on Web

- Podcast browsing and discovery
- Episode list browsing
- Audio streaming (remote URLs)
- Search
- Theme / language switching
- About screen (Impressum/Datenschutz links)
