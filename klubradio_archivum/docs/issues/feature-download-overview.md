# Feature: Merged Download Overview

**Status:** Implemented (not committed)
**Date:** 2026-03-22

## Summary

Merged the 2-tab Download Manager (Active / Completed) into a single scrollable list with visual section headers.

## Changes

### `lib/screens/download_manager_screen/download_list.dart`
- Removed `DefaultTabController`, `TabBar`, and `TabBarView`
- Replaced with a single `ListView` containing both sections
- Two nested `StreamBuilder`s (active + completed) feed into one view
- Added `_SectionHeader` widget for visual separation (icon + bold colored title)
- Extracted `_ActiveDownloadTile` and `_CompletedDownloadTile` as per-item widgets (replacing `_ActiveDownloads` and `_CompletedDownloads` list builders)
- Sections are conditionally shown only when items exist
- Empty state uses `noDownloads` l10n string when both lists are empty

### Popup menu localization fix
- Previously hardcoded German strings ("Abspielen", "Im Ordner oeffnen", "Loeschen")
- Now uses l10n keys: `downloads_menu_play`, `downloads_menu_open_folder`, `downloads_menu_delete`

### "Add to playlist" menu item
- Added `queue` option to completed downloads popup menu
- Calls `EpisodeProvider.addToQueue()` which already existed
- Uses `Icons.playlist_add` icon
- l10n key: `downloads_menu_add_to_queue`

### l10n additions (all 4 languages: de, en, hu, ro)
New keys added to ARB files:
- `downloads_section_active` — section header for active downloads
- `downloads_section_completed` — section header for completed downloads
- `downloads_menu_play` — popup menu: play
- `downloads_menu_open_folder` — popup menu: open in folder
- `downloads_menu_delete` — popup menu: delete
- `downloads_menu_add_to_queue` — popup menu: add to playlist

### `download_manager_screen.dart`
- No changes needed; it already wraps `DownloadList` in an `Expanded` widget

## Technical approach

**Stream merging:** Rather than merging two Drift streams into one combined stream (which would require `Rx.combineLatest2` or similar), two nested `StreamBuilder`s are used. This is simpler, avoids adding an rxdart dependency, and both streams rebuild independently as data changes. The outer `StreamBuilder` handles active downloads, the inner handles completed downloads.

**Section visibility:** Each section (header + items) is wrapped in a conditional `if (items.isNotEmpty)` spread, so empty sections are not rendered at all.

## Verification
- `flutter gen-l10n` completed successfully
- `flutter analyze` reports no issues
