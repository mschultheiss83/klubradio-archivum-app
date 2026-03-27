# Changelog

All notable changes to the Klubrádió Archívum app will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added
- **About Screen** with app info, privacy notice, disclaimer, and contributions list
- **Privacy/Datenschutz notice** shown on first app start (per version) and accessible via Settings and AppBar info button
- **Contributions/Supporters list** loaded from `assets/contributions.json` and displayed in About screen
- **Episode sort order setting** (newest first / oldest first) with ChoiceChips in Playback Settings
- **"Add to playlist" button** in download manager for completed downloads
- **Linux app icon** configuration in `flutter_launcher_icons`

### Changed
- **Download Manager**: merged Active/Completed tabs into single scrollable list with section headers
- **Download Manager**: merged section list now uses `ListView.builder` for lazy item construction
- **Download Manager**: hardcoded German menu texts replaced with l10n strings (4 languages)
- **Unsubscribe dialog**: unified across all 4 screens (was inconsistent before)
- **Download limit default**: now read from Settings DB (`keepLatestN`) instead of hardcoded constant

### Removed
- **RecommendedProvider**: dead code — no API endpoint for recommendations existed (C2)

### Fixed
- **Theme persistence**: ThemeProvider now saves to SharedPreferences (was lost on app restart)
- **Episode sort order bug**: `watchByPodcast()` had no `orderBy` clause (undefined sort order)
- **Database schema**: migrated v2 → v3 for `playOrder` column
- **Settings initialization**: default `settings` row is now created centrally so `playOrder` updates work even before opening download settings
- **Database schema cleanup**: reset `schemaVersion` to `1` and removed obsolete incremental migrations for the unreleased app state
- **C5**: Removed decorative FK constraint from Episodes table (was never enforced, blocked unsubscribed podcast browsing if enabled), bumped schema v3→v4
- **M11 (partial)**: Removed `rethrow` in `toggleSubscription` — callers never await, error became unhandled async exception
- **Deep Bug Scan (43 fixes)** — see `docs/issues/bug-scan-2026-03-26.md` for full details:
  - **Critical**: ProfileProvider null crash (C1), inverted subscribe messages (C3/C4), download queue race condition (C6), async void `_refresh()` (C7)
  - **High**: timing bug H1, ThemeProvider await (H2), onEpisodeDownloaded await (H3), notifyListeners for all downloads (H4), infinite spinner on loadSubscription fail (H6), unsubscribe dialog safety (H7), AudioPlayerService error stream (H8), silent download error suppression (H9), unbounded search results (H10), addRecentSearch on error (H11), RetentionDao null-check (H12), ensureDefaults race condition (H13), discover_screen duplicate init (H14/H15)
  - **Medium**: l10n hardcoded strings (M1-M3), Episode.fromDb description fallback (M4), corrupted cache spinner (M5), stale audio state (M6), ensureDefaults in build (M7), empty episodeId guard (M8), orphaned retention files (M9), slider precision (M13), internal ID in UI (M14)
  - **Low**: cache expiry null-check (L1), Stream.empty (L2), loaded podcasts TTL (L3), autodownload 0 vs null (L4), await Process.run (L5), StreamBuilder hasError (L6), search padding (L7), async File.exists (L8), legal screen l10n (L9), downloader dispose (L10)

## [1.0.4]

### Added
- Editable playlist with swipe-to-delete and animation
- Live search with tabs and episode search
- Comprehensive search tests (27 tests)

### Fixed
- Drift WASM migration and Episode offline cache bug
- MPV locale crash on Linux (LC_NUMERIC=C)
- Pre-commit hook warnings for `.dart_tool` paths
