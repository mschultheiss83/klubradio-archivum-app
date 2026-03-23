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
- **Download Manager**: hardcoded German menu texts replaced with l10n strings (4 languages)
- **Unsubscribe dialog**: unified across all 4 screens (was inconsistent before)
- **Download limit default**: now read from Settings DB (`keepLatestN`) instead of hardcoded constant

### Fixed
- **Theme persistence**: ThemeProvider now saves to SharedPreferences (was lost on app restart)
- **Episode sort order bug**: `watchByPodcast()` had no `orderBy` clause (undefined sort order)
- **Database schema**: migrated v2 → v3 for `playOrder` column

- **Settings initialization**: default `settings` row is now created centrally so `playOrder` updates work even before opening download settings

## [1.0.4]

### Added
- Editable playlist with swipe-to-delete and animation
- Live search with tabs and episode search
- Comprehensive search tests (27 tests)

### Fixed
- Drift WASM migration and Episode offline cache bug
- MPV locale crash on Linux (LC_NUMERIC=C)
- Pre-commit hook warnings for `.dart_tool` paths
