# Feature: About Screen with Privacy/Datenschutz Notice

## Status: Implemented (not committed)

## Summary

Implemented the About screen enhancements and privacy notice system as specified in the backlog.

## Changes Made

### New Files
- **`lib/screens/widgets/privacy_dialog.dart`** — Reusable privacy dialog function (`showPrivacyDialog`) following the same pattern as `unsubscribe_dialog.dart`. Shows privacy notice headline + body and disclaimer headline + body in an AlertDialog.
- **`lib/services/privacy_notice_service.dart`** — Service to manage the one-time-per-version privacy popup. Uses `SharedPreferences` to store the version string when the notice was last shown. Compares against `PackageInfo.fromPlatform()` version.

### Modified Files
- **`lib/screens/about_screen/about_screen.dart`** — Added: Privacy & Security Notice card (opens the privacy dialog), App-ID card (shows `hu.klubradio.archivum`), Contributions placeholder card.
- **`lib/screens/app_shell/app_shell.dart`** — Added: Info/About icon button in the AppBar (right side, all tabs). Added: First-start privacy check in `didChangeDependencies` that calls `PrivacyNoticeService.shouldShowNotice()` and shows the dialog if needed.
- **`lib/screens/settings_screen/settings_screen.dart`** — Added: "Datenschutz & Sicherheitshinweis" card at the bottom of the settings list. Tapping opens the same privacy dialog.
- **`lib/l10n/app_en.arb`** — Added 10 new l10n keys (privacy dialog, disclaimer, settings row, about screen cards).
- **`lib/l10n/app_de.arb`** — Same 10 keys in German.
- **`lib/l10n/app_hu.arb`** — Same 10 keys in Hungarian.
- **`lib/l10n/app_ro.arb`** — Same 10 keys in Romanian.
- **Generated l10n files** — Regenerated via `flutter gen-l10n`.

## New l10n Keys
| Key | Purpose |
|-----|---------|
| `privacyDialogTitle` | Dialog title |
| `privacyNoticeHeadline` | "Your data stays with you." |
| `privacyNoticeBody` | Full privacy notice text (draft) |
| `disclaimerHeadline` | "Disclaimer" |
| `disclaimerBody` | Disclaimer text (draft) |
| `privacySettingsRow` | Settings/About row title |
| `privacySettingsRowSubtitle` | Settings/About row subtitle |
| `aboutScreenAppIdLabel` | "App-ID" label |
| `aboutScreenContributionsTitle` | "Contributions" title |
| `aboutScreenContributionsPlaceholder` | Placeholder text for future donors |

## UI Behavior Implemented

| Where | What | Behavior |
|-------|------|----------|
| First app start (after install or update) | Privacy popup dialog | One-time per version via SharedPreferences `privacyShownVersion` flag |
| Settings screen | "Datenschutz & Sicherheitshinweis" card | Tap opens same privacy dialog |
| All tab headers (AppShell) | Info icon button in AppBar | Navigates to About screen |
| About screen | Privacy & Security Notice card | Tap opens same privacy dialog |

## Design Decisions

1. **First-start check location**: Placed in `_AppShellState.didChangeDependencies()` with a `_privacyCheckDone` flag. This is the earliest point where we have a valid `BuildContext` with `AppLocalizations` available. The check runs once per app session; `PrivacyNoticeService` handles the per-version persistence.

2. **Privacy notice service**: Created as a static utility class (not a Provider) since it only needs to be called in two places (first-start check and dialog display). No need for reactive state.

3. **About button placement**: Added as an `IconButton` with `Icons.info_outline` in the AppBar `actions` list. This appears on every tab since the AppShell has a single AppBar.

4. **Privacy texts are drafts**: The German text is closest to the original backlog draft. English, Hungarian, and Romanian are translations. All can be refined later by editing the ARB files and re-running `flutter gen-l10n`.

## Pre-existing Issues (NOT introduced by this change)

`flutter analyze` reports 5 pre-existing errors related to `playOrder` in `app_database.dart`, `daos.dart`, `podcast_detail_screen.dart`, and `playback_settings.dart`. These are schema migration issues unrelated to this feature. My new/modified files pass analysis cleanly.

## Next Steps
- Refine privacy and disclaimer texts (currently drafts)
- Populate contributions section when donors are available
- Run `flutter gen-l10n` after any ARB text refinements
