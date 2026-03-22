# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **cross-platform Flutter application** (v3.9.2+) that provides podcast-style access to the Klubrádió Archive (https://www.klubradio.hu/archivum). The app supports Android, iOS, Windows, Linux, macOS, and Web platforms.

**Available in 4 languages**: Hungarian, German, English, Romanian (all validated)

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

**All tests (140 tests, ~21 skipped):**
```bash
flutter test
```

**Model unit tests only:**
```bash
flutter test test/models/
```

**Screen utility tests only:**
```bash
flutter test test/screens/utils/
```

**API Live Tests (requires network):**
```bash
flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_service_live_test.dart
flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_model_validation_test.dart
```

**Download Integration Tests:**
```bash
# Unit test mode
flutter test --dart-define DOWNLOAD_LIVE_TESTS=true .\test\integration_test\download_manager_live_test.dart

# Integration test with driver
flutter drive -d windows --driver=test_driver/integration_test.dart --target=integration_test/download_manager_live_test.dart --dart-define DOWNLOAD_LIVE_TESTS=true --dart-define DOWNLOAD_TEST_TIMEOUT_SEC=720 -v
```

### Test Structure
```
test/
├── api/                    # API client tests (mocked HTTP)
├── models/                 # Unit tests for all data models
│   ├── episode_test.dart        (28 tests: fromJson, toJson, copyWith, display helpers)
│   ├── podcast_test.dart        (14 tests: fromJson snake_case, toJson, copyWith)
│   ├── show_host_test.dart      (7 tests)
│   ├── show_data_test.dart      (4 tests)
│   ├── user_profile_test.dart   (10 tests)
│   └── retention_mode_test.dart (3 tests)
├── screens/
│   ├── podcast_detail_screen_test.dart   # Model/logic + documented data flow issues
│   ├── subscription_download_test.dart   # Subscription/download flow logic
│   └── utils/
│       ├── helpers_test.dart        (19 tests: formatDuration, formatProgress, formatDate)
│       ├── constants_test.dart      (10 tests: config validation)
│       └── platform_utils_test.dart (5 tests)
└── services/               # API service tests (mocked + live)
```

**Note:** Widget tests for screens with native plugin dependencies (AudioPlayer, background_downloader) are skipped. See `test/screens/podcast_detail_screen_test.dart` for details.

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
- **Commit & Push**: **ALWAYS use the `/cap` skill** (runs as background subagent). Never do manual git add/commit/push.
  - Usage: `/cap your commit message here`
  - The skill handles: pre-flight checks (git status, flutter analyze, flutter test), staging, committing with `-c` marker, and pushing.
- **Commit messages**:
  - **ALWAYS append agent marker**: `-g` (Gemini), `-c` (Claude), `-a` (Codex)
  - **Do NOT include** "Generated with Claude Code" or "Co-Authored-By: Claude" signatures
  - Keep commit messages clean and focused on the actual changes
  - Example: `/cap fix: resolve download resume logic`

```bash
git checkout dev
git pull origin dev
git checkout -b feature/your-feature-name
# ... make changes ...
# Use /cap to commit and push:
/cap "Your commit message"  # Agent marker -c is appended automatically!
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
- `agent.md`: Multi-agent coordination protocol for GitHub issue processing
- `docs/ARCHITECTURE.md`: Brief architecture overview (in German)
- `docs/project/release-process.md`: Detailed release instructions
- `docs/issues/tracking-major-tasks.md`: Current task tracking

## Multi-Agent Coordination System

This project uses a three-agent coordination system for handling GitHub issues tagged with `apple*`. The system is designed to leverage the strengths of different AI models working together.

### Agent Roles

**Claude Agent (Orchestrator - You are here)**
- Focus: Orchestrating all agents, test validation, deployment coordination
- Responsibilities:
  - Analyze tasks and decide which agents to use (Gemini default, Codex sparingly)
  - Start multiple Gemini/Codex/Claude instances as needed
  - Manage parallel or sequential execution
  - Review test results before commit approval
  - Coordinate deployment via Gemini
  - Escalate to User when needed (API limits, deployment fails, unclear requirements)
  - Architecture oversight (layered architecture, data flows, offline-first, retention policies)
  - Platform-specific requirements validation
  - Git workflow compliance
- Output format: Orchestration plan in `docs/agent-outputs/[issue-id].md`

**Gemini Agent (Primary Worker - kostenlos)**
- Focus: Code implementation, builds, tests, deployment
- Responsibilities:
  - Primary code implementation (Flutter/Dart, Provider/Drift, Supabase)
  - Build/test/deploy execution
  - Schema migrations, bug fixes, refactoring
  - Platform-specific code (Android, iOS, macOS, Windows, Linux, Web)
  - Create/run tests before commit
  - Execute deployment (primary deployer)
  - Can be scaled (multiple instances parallel)
- Output format: Implementation section in `docs/agent-outputs/[issue-id].md`
- Commit marker: `-g`

**Codex Agent (Expert Consultant - kostenpflichtig, sparsam)**
- Focus: Concept phase, code review, critical thinking
- Responsibilities:
  - Feature concept and design (high-level)
  - Heavy code analysis and review
  - Architecture evaluation and alternatives
  - Security & performance deep-dive
  - Used strategically, not as default worker
- Output format: Analysis section in `docs/agent-outputs/[issue-id].md`
- Commit marker: `-a`

**User (Tester & Deployment Coordinator)**
- Reviews issues, formulates tasks
- Starts Claude with task description
- Tests final implementation
- Deploys manually if Gemini deployment fails
- Handles registration, finances, final approval

### Agent Communication Protocol

**Trigger Rules:**
- OpenAI calls Gemini/Claude initially
- Gemini triggers Claude for: architecture, security, offline/retention, platform entitlements questions
- Claude triggers Gemini for: implementation details, API/DB/Provider changes, performance trade-offs

**Supervisor Intervention (OpenAI):**
- Stops ping-pong between agents
- Freezes scope and decides sequentially or parallel execution
- Sets timeboxes for agent work

**Execution Modes:**
- **Parallel (default)**: Gemini handles technical work, Claude handles risks simultaneously
- **Sequential**: When blockers/uncertainties exist (Claude clarifies risks → Gemini implements safe option)

**Cycle Prevention:**
- Maximum 2 back-and-forth exchanges between two agents on the same point
- OpenAI breaks loop and makes executive decision if repeated

**Handoff Indicators:**
- Agents mark "handoff" when missing data, platform dependency, or open risks remain
- Handoffs include: context, assumptions, open questions, recommended next steps

**Status/Context Transfer:**
Every message must include:
- Issue-ID and labels
- Affected platform(s)
- Affected modules/files
- Proposed commands
- Identified risks
- Test plan

### Using Claude Code CLI with Multi-Agent Workflow

**Claude Code Built-in Agents:**
Claude Code provides specialized agents via the Task tool:
- `general-purpose`: Research, code search, multi-step tasks
- `Explore`: Fast codebase exploration (use thoroughness: "quick", "medium", or "very thorough")
- `Plan`: Software architect for implementation planning

**Integrating with External Agents:**
When working with external Gemini and OpenAI agents:
1. Use Claude's Explore agent to gather architectural context
2. Generate risk analysis and architectural flow documentation
3. Share outputs via files in `docs/agent-outputs/` for coordination
4. Read outputs from Gemini/OpenAI agents placed in the same directory

**Agent Output Storage:**
```bash
docs/
├── agent-outputs/
│   ├── claude-risk-analysis.md
│   ├── gemini-implementation-plan.md
│   └── openai-consolidated-plan.md
```

### Claude Agent Checklist (Your Role)

When processing tasks:
1. ✓ Analyze data flows (Download, Playback, Subscription & Auto-Download)
2. ✓ Check offline cache implications (JSON + JPG + MP3)
3. ✓ Evaluate retention policy impacts (Keep Latest N, Delete After Hours)
4. ✓ Verify platform-specific requirements
   - macOS: Entitlements (network, file access, downloads, music)
   - Mobile: WiFi-only mode, permissions
   - Desktop: Application support directory paths
5. ✓ Assess database schema changes via Drift DAOs
6. ✓ Validate state management patterns (Provider dependency chain)
7. ✓ Check git workflow compliance (main/dev, feature branches, commit messages)
8. ✓ Review build/release procedures for all platforms
9. ✓ Identify edge cases and security considerations
10. ✓ Document architectural decisions and trade-offs

### Style Guide for Agent Responses

- Short, precise, numbered steps/bullets; no embellishment
- Every statement ties to Issue-ID/Label/Platform/Module when known
- Commands as code blocks; minimal placeholders; clear flags/paths
- Mention l10n requirement for UI text changes
- Note Drift steps require `dart run build_runner build --delete-conflicting-outputs`
- ARB changes require `flutter gen-l10n`
- No speculation without marking; explicitly flag open questions
- No AI signatures in commit messages (project convention)

### Git Commit Best Practices (from History Analysis)

**Claude Agent Commit Example (from real history):**
```
Commit: 67b7eb0 | 2025-11-12 16:16:55 | claude[bot]
Message: feat: Implement static data bundle infrastructure and modular API refactoring

Structure:
- Phase 1: Static Data Infrastructure (StaticDataService, fetch script, assets)
- Phase 2: API Service Refactoring (6 new API classes)
- Benefits section (instant data access, modular structure)
- Next Steps section (update repositories, deprecate old service)

⚠️ Note: This commit included AI signature "🤖 Generated with Claude Code"
→ New convention: Use -c marker instead, NO AI signatures
```

**Your Commit Template (Orchestration/Architecture):**
```bash
git commit -m "feat: [Architectural change or refactoring]

[Detailed description of the change]

Phase 1: [What was done in first phase]
- [Specific detail 1]
- [Specific detail 2]

Phase 2: [What was done in second phase]
- [Specific detail 1]
- [Specific detail 2]

Benefits:
- [Key benefit 1]
- [Key benefit 2]

Next Steps:
- [Recommended follow-up 1]
- [Recommended follow-up 2]

-c"
```

**When to Create Commits as Claude Agent:**
- Orchestration plans → docs: Update orchestration plan -c
- Risk analysis findings → docs: Add risk analysis for Issue #X -c
- Architectural decisions → docs: Document architectural decision for [feature] -c
- Agent coordination → feat: Coordinate [Gemini/Codex] for [task] -c (if implementing coordination code)
- Test validation → test: Validate test results before commit approval -c
- Deployment coordination → docs: Document deployment coordination steps -c

**Anti-Patterns to Avoid:**
- ❌ AI signatures like "Generated with Claude Code" or "Co-Authored-By: Claude"
- ❌ Vague messages like "Update files" or "Fix stuff"
- ❌ Commits without context or rationale
- ✅ Use -c marker, clear description, architectural context

**Orchestration Workflow:**
1. Analyze task → Create orchestration plan → Commit plan as docs: ... -c
2. Delegate to Gemini/Codex → Track in docs/agent-outputs/
3. Review results → Validate architecture compliance
4. If coordination code needed → Commit with feat: or fix: -c
5. Final consolidation → Commit consolidated plan as docs: ... -c

See `agent.md` for full Git-Log analysis with all agent patterns.
