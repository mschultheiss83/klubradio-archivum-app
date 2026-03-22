# Quick Win 3: Read default download count from Settings DB

## Problem
When creating a new subscription, the auto-download count defaulted to a hardcoded constant (`defaultAutoDownloadCount = 2` in `constants.dart`), ignoring any user-configured `keepLatestN` value in the Settings DB.

## Solution
- Injected `SettingsDao` into `SubscriptionProvider`
- On subscription creation, read `keepLatestN` from the Settings DB
- Fall back to `constants.defaultAutoDownloadCount` if no DB setting exists (first run / unset)

## Files Changed
- `lib/providers/subscription_provider.dart` -- added `settingsDao` field; `toggleSubscription` now reads setting from DB
- `lib/main.dart` -- pass `SettingsDao` when constructing `SubscriptionProvider`

## Data Flow (after fix)
```
Settings DB: keepLatestN (user-configured, nullable)
       |
       v  (fallback if null)
constants.dart: defaultAutoDownloadCount = 2
       |
       v
subscription_provider.dart:toggleSubscription  ->  autoDownloadN for new subscription
       |
       v
Subscriptions table: autoDownloadN (per podcast, overridable)
       |
       v
download_service.dart:416  ->  keepN = sub.autoDownloadN ?? settings.keepLatestN ?? 0
```

## Status
Done. Not committed.
