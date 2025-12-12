# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **cross-platform Flutter application** (v3.9.2+) that provides podcast-style access to the Klubrádió Archive (https://www.klubradio.hu/archivum). The app supports Android, iOS, Windows, Linux, macOS, and Web platforms.

**Key Technologies:**
- **Framework**: Flutter with Dart 3.9.2+
- **State Management**: Provider pattern with ChangeNotifierProxyProvider
- **Database**: Drift ORM with SQLite
- **Audio**: just_audio (+ just_audio_windows for Windows)
- **Downloads**: background_downloader
- **Backend**: Supabase REST API

## Development Commands

### Setup
```bash
cd klubradio_archivum
flutter pub get
```

### Running
```bash
flutter run
```

### Code Generation

**Internationalization (after modifying l10n files):**
```bash
flutter gen-l10n
```

**Database Schema (after modifying Drift schema):**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**App Icons (after updating icon assets):**
```bash
dart run flutter_launcher_icons
```

### Testing

**All tests:**
```bash
flutter test
```

**API Live Tests:**
```bash
flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_service_live_test.dart
```

**Download Integration Tests:**
```bash
# Unit test mode
flutter test --dart-define DOWNLOAD_LIVE_TESTS=true .\test\integration_test\download_manager_live_test.dart

# Integration test with driver
flutter drive -d windows --driver=test_driver/integration_test.dart --target=integration_test/download_manager_live_test.dart --dart-define DOWNLOAD_LIVE_TESTS=true --dart-define DOWNLOAD_TEST_TIMEOUT_SEC=720 -v
```

### Linting
```bash
flutter analyze
```

### Building

**Android:**
```bash
flutter build appbundle  # For Play Store
flutter build apk        # For direct installation
```

**iOS:**
```bash
flutter build ipa
```

**Windows:**
```bash
flutter build windows
```

**macOS:**
```bash
flutter build macos
```

**Web:**
```bash
flutter build web
# Note: Web build needs review - audio playback and download features may need adjustments
```

## Architecture

### Layered Architecture

The app follows a clean layered architecture:

```
UI Layer (Screens/Widgets)
    ↓
Provider Layer (State Management)
    ↓
Service/Repository Layer (Business Logic)
    ↓
Data Layer (API/Database)
```

### Key Architectural Patterns

1. **Repository Pattern**: `PodcastRepository` and `ProfileRepository` abstract data sources with SWR (Stale-While-Revalidate) caching
2. **Provider Pattern**: Dependency injection via `MultiProvider` in `lib/main.dart`
3. **Offline-First**: Episodes cache metadata as JSON + resized JPG cover art for full offline functionality
4. **Persistent Shell**: `AppShell` provides persistent bottom navigation with per-tab navigation stacks

### Critical Service Layer

**DownloadService** (`lib/services/download_service.dart`):
- Most complex service - handles parallel download queue with configurable concurrency
- Features: resume capability, WiFi-only mode, auto-download for subscriptions, retention policies
- After download completion: writes offline cache (JSON + JPG), updates database, applies retention
- Periodic auto-download checker runs every 1 minute for subscribed podcasts

**AudioPlayerService** (`lib/services/audio_player_service.dart`):
- Wraps just_audio package
- Automatically prefers local files over remote URLs when available
- Streams player state, position, and buffering status

**ApiService** (`lib/services/api_service.dart`):
- Communicates with Supabase backend
- Uses ApiCacheService (Hive-based, 3-hour TTL)
- Falls back to mock data when credentials unavailable

### Database Schema (Drift)

Three main tables:

1. **Subscriptions**: Tracks subscribed podcasts, auto-download settings, last heard/downloaded episodes
2. **Episodes**: Download state, progress, local paths, cached metadata, playback tracking
3. **Settings**: Singleton row for app-wide download/retention settings

**Data Access Objects** in `lib/db/daos.dart`:
- SubscriptionsDao, EpisodesDao, SettingsDao, RetentionDao

### Provider Dependency Chain

Initialized in `lib/main.dart` with complex dependency injection:
- `EpisodeProvider` depends on ApiService, AudioPlayerService, AppDatabase
- `DownloadProvider` wraps DownloadService
- `PodcastProvider` orchestrates data loading, coordinates between API and downloads
- `SubscriptionProvider` manages subscriptions and triggers auto-downloads

### Key Data Flows

**Download Flow:**
1. User taps Download → PodcastProvider.downloadEpisode()
2. DownloadService checks resumability (HTTP HEAD), creates DownloadTask
3. background_downloader emits TaskUpdate events
4. On completion: write offline cache, update DB, apply retention, notify EpisodeProvider if playing

**Playback Flow:**
1. User taps Play → EpisodeProvider.playEpisode()
2. Check for cachedMetaPath, read full Episode from JSON if exists
3. AudioPlayerService prefers localFilePath over remote URL
4. PlayerState streams update UI (NowPlayingBar)

**Subscription & Auto-Download:**
1. User subscribes → Update UserProfile and Podcast
2. Schedule auto-download for latest N episodes
3. Periodic timer (1 min) checks for new episodes in subscribed podcasts
4. Enqueue new episodes up to keepN limit

## File Structure

```
lib/
├── api/              # Supabase REST API client
├── db/               # Drift database (schema, DAOs)
├── models/           # Data models (Episode, Podcast, UserProfile)
├── providers/        # State management (Provider pattern)
├── repositories/     # Repository layer (SWR caching)
├── services/         # Business logic (Download, Audio, API, Cache)
├── screens/          # UI screens
│   ├── app_shell/    # Persistent navigation shell
│   ├── home_screen/
│   ├── discover_screen/
│   ├── podcast_detail_screen/
│   ├── now_playing_screen/
│   ├── download_manager_screen/
│   ├── settings_screen/
│   └── widgets/      # Reusable UI components
├── utils/            # Utility functions
└── l10n/             # Internationalization (de, en, hu)
```

## Development Conventions

### Code Style
- Use `flutter_lints` for code analysis (configured in `analysis_options.yaml`)
- Run `flutter analyze` before committing

### Internationalization
- All user-facing strings must use l10n
- After modifying `.arb` files in `lib/l10n/`, run `flutter gen-l10n`
- Access via `AppLocalizations.of(context)`

### State Management
- Use `Provider.of<T>(context, listen: false)` for read-only access
- Use `context.watch<T>()` for reactive updates
- Use `StreamBuilder` for real-time updates (downloads, playback position)

### Persistence Strategy
- **SharedPreferences**: App settings, theme, language, playback speed
- **Drift (SQLite)**: Structured data (subscriptions, episodes, download state)
- **Hive**: API cache (short-term, 3-hour TTL)
- **File System**: Downloaded MP3s, cached JSON metadata, resized JPG covers

### Git Workflow
- **Main branch**: `main` (for releases)
- **Development branch**: `dev`
- **Feature branches**: Create from `dev` with naming `feature/your-feature-name`
- **Commit messages**:
  - Use `git commit --quiet` to reduce output verbosity (project convention)
  - **Do NOT include** "Generated with Claude Code" or "Co-Authored-By: Claude" signatures
  - Keep commit messages clean and focused on the actual changes

```bash
git checkout dev
git pull origin dev
git checkout -b feature/your-feature-name
```

### Task Management
- Major tasks are tracked in `docs/project/` and `klubradio_archivum/docs/issues/`
- Check `git status` and `flutter analyze` before resuming work
- Consult `docs/issues/tracking-major-tasks.md` for ongoing work

## Important Implementation Details

### Offline Cache Format
After downloading an episode, the app creates:
1. **JSON file** (`{episode_id}_metadata.json`): Full Episode object with all metadata
2. **JPG file** (`{episode_id}_cover.jpg`): Resized cover art (500x500)
3. **MP3 file**: The audio file itself

This allows the app to display full episode information even when offline.

### Retention Policies
Two configurable policies (in Settings table):
1. **Keep Latest N**: Per podcast, only keep N most recent downloads
2. **Delete After Hours**: Remove played episodes after X hours

Applied automatically after each download completion via `RetentionDao`.

### Platform-Specific Considerations
- **Mobile (Android/iOS)**: WiFi-only downloads enabled by default, requires permissions
- **Desktop (Windows/Linux/macOS)**: WiFi restriction disabled, uses application support directory
- **Audio playback**: just_audio handles both `file://` and `https://` URLs seamlessly
- **macOS Entitlements**: Required entitlements in `macos/Runner/DebugProfile.entitlements` and `Release.entitlements`:
  - `com.apple.security.network.client` - Outgoing network connections
  - `com.apple.security.files.user-selected.read-write` - File access
  - `com.apple.security.files.downloads.read-write` - Downloads folder access
  - `com.apple.security.assets.music.read-write` - Audio files access

### Build Configuration
- **Application ID**: `hu.klubradio.archivum`
- **Bundle ID (iOS)**: `hu.klubradio.archivum`
- **Min SDK (Android)**: 21
- **Icons**: Managed via `flutter_launcher_icons` in `pubspec.yaml`

## Release Process

See `docs/project/release-process.md` for detailed instructions.

**Version updates**: Modify `version` in `pubspec.yaml` (format: `major.minor.patch+build`)

**Testing on Platforms:**
Before release, test builds on all supported platforms:
- **Android**: `flutter build apk` or `flutter build appbundle`
- **iOS**: `flutter build ipa`
- **macOS**: `flutter build macos`
- **Windows**: `flutter build windows`
- **Web**: `flutter build web` (requires additional testing for audio/download features)

**Release Uploads:**
- **Android**: Upload to Google Play Console
- **iOS**: Upload via Transporter or Xcode to App Store Connect
- **macOS**: Package as .dmg or upload to Mac App Store

## Related Files
- `GEMINI.md`: Context file for Gemini AI assistant (similar purpose to this file)
- `docs/ARCHITECTURE.md`: Brief architecture overview (in German)
- `docs/project/release-process.md`: Detailed release instructions
- `docs/issues/tracking-major-tasks.md`: Current task tracking

