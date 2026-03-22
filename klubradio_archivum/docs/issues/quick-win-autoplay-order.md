# Quick Win: Configurable Episode Sort Order

## Status: Implementation complete, pending code generation

## Changes Made

### 1. Bug Fix: `watchByPodcast()` missing orderBy (lib/db/daos.dart)
- **Before**: `watchByPodcast()` had NO `orderBy` clause, resulting in undefined/random order
- **After**: Added `orderBy publishedAt DESC` as default, with an optional `ascending` parameter
- Signature: `watchByPodcast(String podcastId, {bool ascending = false})`

### 2. New DB Column: `playOrder` in Settings table (lib/db/app_database.dart)
- Added `TextColumn playOrder` with default value `'newest'`
- Valid values: `'newest'` or `'oldest'`
- Schema version bumped from 2 to 3
- Migration added: `m.addColumn(settings, settings.playOrder)` for `from < 3`

### 3. DAO Updates (lib/db/daos.dart)
- Added `setPlayOrder(String order)` method to `SettingsDao`
- Updated `ensureDefaults()` to include `playOrder: 'newest'`

### 4. Podcast Detail Screen (lib/screens/podcast_detail_screen/podcast_detail_screen.dart)
- Wrapped the episode list `StreamBuilder` with an outer `StreamBuilder<Setting?>` that reads the current `playOrder` setting
- Passes `ascending: true` to `watchByPodcast()` when `playOrder == 'oldest'`

### 5. Settings UI (lib/screens/settings_screen/playback_settings.dart)
- Added "Episode order" section with two `ChoiceChip` widgets: "Newest first" / "Oldest first"
- Uses a `StreamBuilder<Setting?>` to reactively reflect the current setting
- Placed in the Playback Settings card, below the playback speed chips

### 6. Localization (lib/l10n/app_*.arb)
Added 3 new l10n keys in all 4 languages:

| Key | EN | DE | HU | RO |
|-----|----|----|----|----|
| `settings_episode_order_label` | Episode order | Episoden-Reihenfolge | Epizodok sorrendje | Ordinea episoadelor |
| `settings_episode_order_newest` | Newest first | Neueste zuerst | Legujabb elol | Cele mai noi primele |
| `settings_episode_order_oldest` | Oldest first | Alteste zuerst | Legregebbi elol | Cele mai vechi primele |

### 7. Auto-Download Sort (lib/services/download_service.dart) -- NOT CHANGED
- The auto-download at line 424 sorts by `publishedAt DESC` to pick the *newest* N episodes
- This is intentional: auto-download should always target the newest episodes regardless of display order
- The `playOrder` setting only affects UI display order, not download selection logic

## Required Post-Steps

1. **Run Drift code generation** (REQUIRED before the code compiles):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Run l10n generation** (already done):
   ```bash
   flutter gen-l10n
   ```

3. **Run `flutter analyze`** to verify no issues after code generation

4. **Test manually**:
   - Open Settings > Playback Settings > verify "Episode order" chips appear
   - Toggle to "Oldest first" and open a podcast detail -- episodes should be in ascending date order
   - Toggle back to "Newest first" -- episodes should be in descending date order
   - App upgrade from schema v2 to v3 should migrate cleanly

## Architecture Decision: Global setting only (for now)
- Per the backlog decision: Global setting now, per-podcast override later
- Hierarchy for future: Podcast-Setting > Global Setting
- The `ascending` parameter on `watchByPodcast()` already supports per-podcast override when needed

## Files Modified
- `lib/db/app_database.dart` -- new column + migration
- `lib/db/daos.dart` -- bug fix orderBy, new DAO method, ensureDefaults
- `lib/screens/podcast_detail_screen/podcast_detail_screen.dart` -- reads setting for sort order
- `lib/screens/settings_screen/playback_settings.dart` -- new UI toggle
- `lib/l10n/app_en.arb` -- 3 new keys
- `lib/l10n/app_de.arb` -- 3 new keys
- `lib/l10n/app_hu.arb` -- 3 new keys
- `lib/l10n/app_ro.arb` -- 3 new keys
