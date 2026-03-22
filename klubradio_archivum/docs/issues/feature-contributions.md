# Feature: Contributions/Supporters List in About Screen

**Status:** Implemented (not yet committed)
**Date:** 2026-03-22

## Summary

Replaced the static "Contributions" placeholder in the About screen with a dynamic supporters list loaded from a JSON asset file.

## Changes

### New file
- `assets/contributions.json` — JSON array of `{ "name": "..." }` objects. Easy to maintain by non-developers.

### Modified files
- `pubspec.yaml` — registered `assets/contributions.json`
- `lib/screens/about_screen/about_screen.dart` — loads contributors from JSON via `rootBundle.loadString()`, displays them as a list with heart icons; shows localized empty-state message if list is empty
- `lib/l10n/app_en.arb` — replaced `aboutScreenContributionsPlaceholder` with `aboutScreenContributionsEmpty` ("Become a supporter!"), updated title to "Supporters"
- `lib/l10n/app_de.arb` — "Werde Unterstützer!"
- `lib/l10n/app_hu.arb` — "Légy támogató!"
- `lib/l10n/app_ro.arb` — "Devino susținător!", title updated to "Susținători"
- `lib/l10n/app_localizations*.dart` — auto-regenerated via `flutter gen-l10n`

## JSON Format

```json
[
  { "name": "Max Mustermann" },
  { "name": "Jane Doe" }
]
```

To add a new supporter, simply append an object with a `name` field.

## Verification
- `flutter analyze`: No issues found
- `flutter gen-l10n`: All 4 locales regenerated successfully
