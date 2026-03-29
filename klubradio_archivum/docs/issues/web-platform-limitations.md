# Web Platform Limitations

**Status:** Active design decision
**Date:** 2026-03-29

## Overview

The web build runs at `https://multilevelstudios.de/klubradio/` as a
showcase/preview. Several native features are intentionally disabled because
they don't apply to a browser environment.

## Disabled Features on Web

| Feature | Reason | Guard |
|---------|--------|-------|
| Downloads | No file system access | `PlatformUtils.supportsDownloads` → `!kIsWeb` |
| Subscriptions | Depends on local DB + download service | `PlatformUtils.supportsSubscriptions` → `!kIsWeb` |
| Offline cache (JSON/JPG/MP3) | No file system | Download service not initialized |
| Background audio | Limited browser support | `PlatformUtils.supportsBackgroundAudio` → `!kIsWeb` |
| WiFi-only mode | Not applicable | Download service not initialized |

## Database on Web

**Problem:** Drift's recommended `drift/wasm.dart` requires `sqlite3.wasm` and
`drift_worker.js` files deployed alongside the app. These add ~2MB and
complexity for features that are disabled on web anyway.

**Solution:** `lib/db/connection/connection_web.dart` uses the legacy
`drift/web.dart` (`WebDatabase`) which stores data in `localStorage`. This is
sufficient because:

- Downloads are disabled (no episode rows with local paths)
- Subscriptions are disabled (no subscription rows)
- Settings defaults are written but rarely read
- The DB exists only to satisfy the provider dependency chain

The `deprecated_member_use` lint is suppressed with a comment explaining the
trade-off.

## Build Configuration

- **Base href:** `--base-href /klubradio/` (set in `.github/workflows/deploy-web.yml`)
- **Deploy path:** `https://multilevelstudios.de/klubradio/`
- `dart:io` is not imported in `main.dart` — platform detection uses
  `defaultTargetPlatform` from `package:flutter/foundation.dart`

## What Works on Web

- Podcast browsing and discovery
- Episode list browsing
- Audio streaming (remote URLs via just_audio)
- Search
- Theme switching
- Language switching (4 languages)
- About screen with Impressum/Datenschutz links

## Future Considerations

If full web DB support is ever needed, migrate `connection_web.dart` to
`drift/wasm.dart` and include `sqlite3.wasm` + `drift_worker.js` in the
`web/` directory. See https://drift.simonbinder.eu/web for setup instructions.
