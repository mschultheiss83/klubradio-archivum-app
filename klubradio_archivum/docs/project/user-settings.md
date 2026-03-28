# User Settings Reference

Overview of all user-configurable settings, where they are stored, and how they are used.

## Settings Overview

| Setting | Storage | UI Location | Default | Used In |
|---------|---------|-------------|---------|---------|
| **autoDownloadEpisodeCount** | SharedPreferences (UserProfile) | Settings > Downloads | 2 | Auto-download logic |
| **wifiOnly** | Drift DB (Settings) | Settings > Downloads | true (mobile) | DownloadService |
| **autodownloadSubscribed** | Drift DB (Settings) | Settings > Downloads | false | DownloadService timer |
| **maxParallel** | Drift DB (Settings) | Settings > Downloads | 1 | DownloadService queue |
| **keepLatestN** | Drift DB (Settings) | Settings > Downloads > Retention | null | RetentionDao |
| **deleteAfterHours** | Drift DB (Settings) | Settings > Downloads > Retention | null | RetentionDao |
| **playbackSpeed** | SharedPreferences (UserProfile) | Settings > Playback | 1.0 | AudioPlayerService |
| **playOrder** | Drift DB (Settings) | Settings > Playback | 'newest' | EpisodesDao.watchByPodcast |
| **themeMode** | SharedPreferences | Settings > Theme | system | ThemeProvider |
| **languageCode** | SharedPreferences (UserProfile) | Settings > Language | 'de' | AppLocalizations |
| **autoDownloadN** | Drift DB (Subscriptions) | Per-podcast | null | DownloadService (per-podcast override) |

## Download Settings (Distinct Concepts)

### 1. Auto-Download Episode Count (`autoDownloadEpisodeCount`)
- **What**: How many episodes to auto-download per subscription when subscribing or on periodic check.
- **Fallback chain**: Per-podcast `autoDownloadN` > global `autoDownloadEpisodeCount` > `defaultAutoDownloadCount` (2)
- **Storage**: `UserProfile.autoDownloadEpisodeCount` in SharedPreferences
- **Where set**: Settings > Downloads > "Automatic Downloads" stepper
- **Where read**: `SubscriptionProvider.toggleSubscription()`, `DownloadService.autodownloadPodcast()`

### 2. Max Parallel Downloads (`maxParallel`)
- **What**: How many files can be downloaded simultaneously.
- **Storage**: `Settings.maxParallel` in Drift DB
- **Where set**: Settings > Downloads > "Max parallel" stepper
- **Where read**: `DownloadService._processQueue()` — controls `_activeDownloadCount < maxParallel`

### 3. Retention: Keep Latest N (`keepLatestN`)
- **What**: After downloading, only keep the N most recent episodes per podcast. Older completed downloads are deleted.
- **Storage**: `Settings.keepLatestN` in Drift DB
- **Where set**: Settings > Downloads > Retention mode chips > "Keep latest" stepper
- **Where read**: `RetentionDao.computePlanForPodcast()` — runs after each download completes

### 4. Retention: Delete After Hours (`deleteAfterHours`)
- **What**: Delete played episodes after X hours.
- **Storage**: `Settings.deleteAfterHours` in Drift DB
- **Where set**: Settings > Downloads > Retention mode chips > "Delete after heard" stepper
- **Where read**: `RetentionDao.computePlanForPodcast()` — checks `lastPlayedAt + hours < now`

### 5. WiFi Only (`wifiOnly`)
- **What**: Only download over WiFi (mobile only).
- **Storage**: `Settings.wifiOnly` in Drift DB
- **Where set**: Settings > Downloads > WiFi switch
- **Where read**: `DownloadService._startDownload()` — sets `requiresWiFi` on DownloadTask

### 6. Auto-Download Subscribed (`autodownloadSubscribed`)
- **What**: Enable periodic auto-download check (every 1 min) for all active subscriptions.
- **Storage**: `Settings.autodownloadSubscribed` in Drift DB
- **Where set**: Settings > Downloads > auto-download switch
- **Where read**: `DownloadService.checkAutodownloads()` — guards the periodic timer logic

## Playback Settings

### 7. Playback Speed (`playbackSpeed`)
- **What**: Audio playback speed (0.5x - 2.0x).
- **Storage**: `UserProfile.playbackSpeed` in SharedPreferences
- **Where set**: Settings > Playback > Speed chips
- **Where read**: Restored on app start (`AppShell._restorePlaybackSpeed`), applied on each `playEpisode()`

### 8. Episode Sort Order (`playOrder`)
- **What**: Sort episodes newest-first or oldest-first.
- **Storage**: `Settings.playOrder` in Drift DB
- **Where set**: Settings > Playback > Order chips
- **Where read**: `EpisodesDao.watchByPodcast()` — determines ORDER BY direction

## Storage Architecture

Two persistence mechanisms:

1. **SharedPreferences** (via `ProfileRepository` / `UserProfile`):
   - `autoDownloadEpisodeCount`, `playbackSpeed`, `languageCode`
   - `subscribedPodcastIds`, `favouriteEpisodeIds`, `recentlyPlayed`
   - Loaded once at app start via `ProfileProvider.load()`

2. **Drift SQLite DB** (via `SettingsDao` / `Settings` table):
   - `wifiOnly`, `maxParallel`, `keepLatestN`, `deleteAfterHours`, `autodownloadSubscribed`, `playOrder`
   - Singleton row (id=1), created by `SettingsDao.ensureDefaults()`
   - Watched reactively via Drift streams
