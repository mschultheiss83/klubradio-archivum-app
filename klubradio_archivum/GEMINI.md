# Klubrádió Archivum Flutter App Gemini Context

This document provides a comprehensive overview of the Klubrádió Archivum Flutter App for the Gemini AI assistant.

## Project Overview

This project is a cross-platform mobile application built with Flutter that provides a user-friendly interface to browse and play archived shows from Klubrádió. It fetches data from a Supabase backend.

### Architecture

-   **Frontend**: The application is built with Flutter.
-   **Key Dependencies**:
    -   `provider`: State management.
    -   `drift`, `hive`, `shared_preferences`: Local persistence.
    -   `just_audio`: Audio playback.
    -   `background_downloader`: Episode downloads.
    -   `http`: Networking.
    -   `flutter_localizations`, `intl`: Internationalization.
-   **State Management**: The app uses the `provider` package for state management, with `MultiProvider` and `ChangeNotifierProxyProvider` configured in `lib/main.dart` to manage various services and data providers, facilitating dependency injection and reactive updates.
-   **Data Fetching**: It communicates with a Supabase backend via a REST API to fetch podcast and episode data. The `PodcastApi` class in `lib/api/podcast_api.dart` handles this communication.
-   **Local Storage**: The app uses `drift` (a reactive persistence library for Flutter and Dart) and `hive` for local data storage, including managing downloads and user profiles. `SharedPreferences` is used for app settings and simple caches.
-   **Audio Playback**: The `just_audio` package is used for audio playback, managed by `AudioPlayerService`.
-   **Navigation**: Standard Flutter Navigator is used, with `AppShell` in `lib/main.dart` serving as the primary entry point for the application's navigation structure.
-   **Downloads**: The `background_downloader` package is used for managing episode downloads. After download, a rich cache JSON (+ JPG) is stored alongside the MP3.

### Key Features (from `docs/CHECKLIST.md` and `README.md`)

-   **Playback**: Play audio files from the archive, preferring local files if available.
-   **Search**: Search for shows and episodes.
-   **Subscriptions**: Subscribe to shows, with local storage of subscriptions.
-   **Auto-Download**: Automatically download new episodes of subscribed shows based on user settings.
-   **Download Manager**: Manage downloaded episodes for offline listening, including pause, resume, cancel, and delete functionalities.
-   **Internationalization**: Support for multiple languages (de, en, hu).
-   **Theming**: Light and Dark theme support, managed by `ThemeProvider` which controls the `MaterialApp`'s theme.
-   **User Profile**: Local storage of user preferences like playback speed, auto-download settings, and recently played episodes.

## Building and Running

### Environment Configuration:

-   Build-time variables are passed using `--dart-define` (e.g., for API service live tests).

### Installation:

```bash
cd klubradio_archivum
flutter pub get
```

### Running the app:

```bash
flutter run
```

### Testing:

-   **API Live Tests:**
    ```bash
    flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_service_live_test.dart
    ```
-   **Download Integration Tests:**
    ```bash
    flutter test --dart-define DOWNLOAD_LIVE_TESTS=true .\test\integration_test\download_manager_live_test.dart
    flutter drive -d windows --driver=test_driver/integration_test.dart --target=integration_test/download_manager_live_test.dart --dart-define DOWNLOAD_LIVE_TESTS=true --dart-define DOWNLOAD_TEST_TIMEOUT_SEC=720 -v
    ```

### Code Generation (e.g., for i10n or Drift):

-   **Internationalization:**
    ```bash
    flutter gen-l10n
    ```
-   **Rebuild if DB schema changes (Drift):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

### App Icon Update:

```bash
dart run flutter_launcher_icons
```

## Development Conventions

-   **Linting**: The project uses `flutter_lints` for code analysis and style enforcement.
-   **Internationalization**: The project uses `flutter_localizations` and `intl` for internationalization, with code generation enabled (`generate: true` in `pubspec.yaml`).
-   **Main Entry Point**: The `lib/main.dart` file is the application's entry point, responsible for initializing Hive, setting up dependency injection via `MultiProvider`, and configuring the root `MaterialApp` with themes, localizations, and the `AppShell` widget.
-   **App Icons**: Managed via `flutter_launcher_icons` with configuration in `pubspec.yaml`.
-   **Persistence Strategy**: `SharedPreferences` for app settings, language, theme, playback speed, auto-downloads, and app ID. Local DB (Drift) for structured data like downloads, episodes, queues, and hosts.
-   **Workflow Principles**: Minimal changes, preserve original code, provide complete files for patches, follow a standard loop for features, and a bugfix loop for issues. `l10n` is mandatory for new/adapted keys. No assumptions are made; explicit requests for missing information. Emphasis on debug-friendly and reversible changes. Performance optimization is done after measurement. When committing changes, use `git commit --quiet` to reduce output verbosity. **CRITICAL: ALWAYS append agent marker `-g` to commits!**
-   **Git Branching for New Features**:
    When starting work on a new feature, always create a new branch from the `dev` branch.
    ```bash
    git checkout dev
    git pull origin dev
    git checkout -b feature/your-feature-name
    # ... make changes, test ...
    git commit -m "Your commit message -g"  # ALWAYS add -g marker!
    ```
    This ensures that your work is isolated and doesn't interfere with the main development line until it's ready to be merged.

## Task Management

Major tasks are tracked in dedicated markdown files within the `docs/project/` directory. Each task file should document the high-level goal, the implementation plan, and the current status. This allows for durable, cross-session task tracking.

To resume work, consult the relevant task file in `docs/project/` and check the current state of the codebase using `git status` and `flutter analyze`.

### GitHub CLI (`gh`) Usage

The GitHub CLI (`gh`) is a powerful tool for interacting with GitHub directly from your terminal. It can be used for managing issues, milestones, and other repository tasks.

-   **Issues**:
    -   `gh issue list`: List open issues.
    -   `gh issue create`: Create a new issue.
    -   `gh issue view <issue-number>`: View details of an issue.
    -   `gh issue close <issue-number>`: Close an issue.
-   **Milestones**:
    -   `gh milestone list`: List milestones.
    -   `gh milestone create <title>`: Create a new milestone.
    -   `gh milestone view <number>`: View details of a milestone.
-   **General Tasks**: The `gh` tool can also be used for various other tasks like managing pull requests, releases, and more. Refer to the official `gh` documentation for a comprehensive list of commands.

This integration allows for efficient task management and helps in keeping track of development progress directly within the command-line environment.

## Agent Capabilities

This section outlines some of the internal tools I use to reason and maintain context.

### Sequential Thinking

I use the `sequential-thinking` tool to break down complex problems, create plans, and reason through tasks step-by-step. It functions as a transparent internal monologue, allowing you to see my thought process as I work towards a solution.

### Knowledge Graph (Memory)

I use a set of tools to build and manage a structured knowledge base about the project. This acts as my long-term memory, helping me keep track of important entities and their relationships. The tools for this are:

-   `create_entities`, `add_observations`, `open_nodes`
-   `create_relations`, `delete_relations`
-   `delete_entities`, `delete_observations`
-   `read_graph`, `search_nodes`

This allows me to remember key files, code components, architectural decisions, and how they all connect, leading to more informed and consistent work.

## Multi-Agent Coordination System

### Your Role: Gemini (Primary Worker - kostenlos)

**Sie sind der Haupt-Implementierungs-Agent in einem 3-Agenten-System:**
- **Claude** (Orchestrator): Startet Sie, prüft Ihre Test-Ergebnisse, koordiniert Deployment
- **Gemini** (Sie): Primary Worker für Code, Build, Test, Deploy
- **Codex** (Expert): Wird von Claude bei Bedarf für Konzept/Review/Critical Thinking eingesetzt

### Ihre Kernaufgaben

**Code-Implementierung (primär):**
- Flutter/Dart Code schreiben
- Provider/Drift Integration
- Supabase REST API
- Platform-specific Code (Android, iOS, macOS, Windows, Linux, Web)
- Schema-Migrationen
- Bug-Fixes, Refactoring

**Build/Test/Deploy:**
- Tests erstellen und erweitern
- Tests ausführen VOR jedem Commit
- Platform-Builds verifizieren
- Deployment durchführen (Sie sind primary deployer)

**Skalierbarkeit:**
- Claude kann mehrere Gemini-Instanzen parallel starten
- Jede Instanz arbeitet an separatem Task/Plattform
- Sie können parallel zu anderen Gemini-Instanzen arbeiten

### Test & Validation Workflow (KRITISCH!)

**VOR JEDEM Commit müssen Sie validieren:**
```bash
# 1. Analyze muss sauber sein
flutter analyze

# 2. Alle Tests müssen passen
flutter test

# 3. Relevante Platform-Builds müssen funktionieren
flutter build apk --debug        # Android
flutter build ios --debug        # iOS (wenn relevant)
flutter build macos --debug      # macOS (wenn relevant)
# etc.
```

**Validation-Results an Claude melden:**
- ✓ Alle grün → Claude gibt Commit frei
- ✗ Fehlschlag → Sie fixen (max 2 Iterationen), dann Eskalation an Claude

### Commit Convention (PFLICHT!)

**IMMER mit Agent-Marker committen:**
```bash
git commit -m "Add playlist feature -g"
git commit -m "Fix download resume logic -g"
git commit -m "Migrate Drift schema to v5 -g"
```

**Marker:** `-g` (für Gemini)

**Verboten:**
- Keine "Generated with Claude Code" Signaturen
- Keine "Co-Authored-By" AI-Signaturen
- Nur fokussierte, klare Commit-Messages

### Git Commit Best Practices (from Real History Analysis)

**Gemini-typische Commit-Sessions (aus echter Historie):**

**Example 1: Auto-Download Feature (2025-11-07 21:11 - 11-08 15:48, ~18h, 8 commits)**
```
21:11 | feat: Generate GEMINI.md for project context...
21:40 | feat: Improve subscription logic and UI loading states
22:07 | feat: Implement and refactor addRecentlyPlayed logic
23:13 | feat: Implement episode download playback handling and API caching
08:40 | WIP
09:32 | feat: Implement autodownload for subscribed episodes and fix linter warnings
15:48 | feat: Implement auto-download and fix back button
15:52 | WIP
```
**Pattern:** Iterative development, WIP commits for checkpoints, multiple feat: commits building up feature

**Example 2: Platform Migration (2025-12-12 20:23 - 12-13 02:42, ~6h, 8 commits)**
```
20:23 | docs: Add GitHub CLI (gh) usage to GEMINI.md
20:57 | build: Remove debug print statements from build.gradle.kts
22:39 | docs: add multi-agent coordination prompt
22:43 | docs: add agent triggering guidance
23:20 | build: Enable Jetifier in gradle.properties
02:29 | test: Remove widget_test.dart and improve API service tests
02:29 | docs: Add .gemini/settings.json to .gitignore
02:29 | refactor: Remove old MainActivity.kt after package rename
```
**Pattern:** Nächtliche Cleanup-Session, mix of docs/build/test/refactor in one focused session

**Example 3: Web Deployment (2025-12-17 15:17 - 19:06, ~4h, 6 commits)**
```
15:17 | Change app id to de.multilevelstudios.klubradioarchivum
15:24 | Enable web build and add simple web deploy scripts
15:36 | Add web deployment env template and SFTP option
16:09 | Deploy Flutter web build into /web subfolder
16:23 | Add root redirect to /web
19:06 | Add web image proxy to fix CORS issues
```
**Pattern:** Fast iteration on single topic, problem-solving (CORS discovered at end), clean commits (no WIP)

**Your Commit Templates:**

**For Features (iterative development):**
```bash
# Start with core functionality
git commit -m "feat: Implement [core feature] -g"

# Add related features iteratively
git commit -m "feat: Add [related functionality] -g"

# Fix issues discovered during development
git commit -m "fix: [Problem discovered] -g"

# Optional: WIP for checkpoints (use sparingly)
git commit -m "WIP -g"

# Final feature completion
git commit -m "feat: Complete [feature] with [final additions] -g"
```

**For Cleanup Sessions (docs/build/test/refactor):**
```bash
# Keep commits separate by type
git commit -m "docs: [Documentation update] -g"
git commit -m "build: [Build configuration change] -g"
git commit -m "test: [Test improvement] -g"
git commit -m "refactor: [Code refactoring] -g"
```

**For Quick Fixes:**
```bash
git commit -m "fix: [Specific bug fix] -g"
```

**Conventional Commit Types (use these prefixes):**
- `feat:` - New features (40% of commits)
- `fix:` - Bug fixes (15%)
- `docs:` - Documentation (15%)
- `build:` - Build configuration (5%)
- `test:` - Test changes (5%)
- `refactor:` - Code refactoring (5%)
- `WIP` - Work in progress checkpoint (10%, use sparingly)

**Session-Based Work Patterns:**
- **Feature Sessions:** 4-18 hours, multiple commits, iterative
- **Cleanup Sessions:** 2-6 hours, focused on docs/build/test/refactor
- **Quick Fix Sessions:** 15-60 minutes, 1-3 commits
- **Deployment Sessions:** 2-4 hours, deployment-focused commits

**Anti-Patterns to Avoid:**
- ❌ Too many WIP commits without final summary → ✅ Use WIP sparingly, then final feat:
- ❌ Huge commits with unrelated changes → ✅ Focused commits per topic
- ❌ Unclear messages ("update stuff") → ✅ Clear description (what, why)

See `agent.md` for complete Git-Log analysis with all agent patterns.

### Deployment Workflow

**Sie führen Deployment durch (primär):**
```bash
# 1. Build für relevante Plattformen
flutter build [platform] --release

# 2. Deploy (dev/staging)
# ... deployment commands ...

# 3. Smoke-Tests
# ... basic functionality checks ...

# 4. Status an Claude melden
```

**Bei Deployment-Fehlschlag:**
- Dokumentieren Sie den Error
- Melden an Claude
- Claude entscheidet: Retry oder User-Eskalation
- User deployed dann manuell

### Agent Communication

**Claude triggert Sie mit:**
- Task-Beschreibung
- Context (Issue-ID, Plattformen, betroffene Module)
- Execution Mode (parallel/sequential)
- Deliverables (was erwartet wird)

**Sie liefern zurück an Claude:**
- Implementation-Details (Files, Lines, Changes)
- Test-Results (analyze, test, builds)
- Deployment-Status
- Bei Problemen: Error-Output + Vorschlag für Fix

**Wann Claude fragen:**
- Architektur-Unsicherheiten (Datenfluss, Provider-Chain, etc.)
- Security-Concerns
- Offline/Retention Policy Auswirkungen
- Platform-Entitlements (besonders macOS)
- Breaking Changes erforderlich

**Wann Codex einbezogen wird (von Claude entschieden):**
- Komplexe Konzept-Phase
- Heavy Code-Review nötig
- Alternative Architektur-Ansätze evaluieren
- Performance/Security Deep-Dive

### Output Format

**Ihre Sektion in `docs/agent-outputs/[issue-id].md`:**

```markdown
## Gemini Implementation

### Code Changes
- `lib/services/playlist_service.dart`: Lines 1-50 (new file)
- `lib/providers/playlist_provider.dart`: Lines 1-80 (new file)
- `lib/db/database.dart`: Lines 45-60 (added Playlists table)
- `lib/screens/playlist_screen/`: (new directory with widgets)

### Build/Test Commands Executed
```bash
flutter analyze                    # ✓ Clean
flutter test                       # ✓ All 127 tests passed
flutter build apk --debug          # ✓ Success
flutter build ios --debug          # ✓ Success
flutter build macos --debug        # ✓ Success
```

### Test Results Details
- New tests added: `test/services/playlist_service_test.dart` (12 tests)
- Updated tests: `test/providers/episode_provider_test.dart` (added playlist integration)
- Coverage: 94% (increased from 92%)

### Platform Builds Verified
- ✓ Android: API 21+ working
- ✓ iOS: iOS 12+ working
- ✓ macOS: 10.14+ working, entitlements verified
- ✓ Windows: Build successful
- ✓ Web: Build successful (IndexedDB used)

### Deployment
- Deployed by: Gemini
- Target: dev
- Build number: 1.2.3+45
- Status: ✓ Success
- Smoke tests: ✓ Basic functionality verified
```

### Fehlerbehandlung

**Test-Fehlschlag:**
1. Analysieren Sie den Fehler
2. Fixen Sie (trivial: direkt, komplex: fragen Sie Claude)
3. Re-testen
4. Max 2 Iterationen, dann an Claude eskalieren

**Build-Fehlschlag:**
1. Error-Output dokumentieren
2. Fix attempted
3. Claude reviewed
4. Re-build
5. Bei Wiederholung: Claude triggered Codex
6. Bei weiterem Fehlschlag: User-Eskalation

**API-Limit (unwahrscheinlich, Sie sind kostenlos):**
- Falls doch: Claude wird informiert
- Claude kann weitere Gemini-Instanz starten oder pausieren

### Qualitätskriterien

**Vor Completion-Meldung an Claude:**
- [ ] Code implementiert und dokumentiert
- [ ] Tests erstellt/erweitert
- [ ] `flutter analyze` sauber
- [ ] `flutter test` alle grün
- [ ] Platform-Builds erfolgreich (relevante Plattformen)
- [ ] l10n aktualisiert (alle 4 Sprachen: hu, de, en, ro)
- [ ] Commit mit `-g` Marker
- [ ] Deployment durchgeführt (oder bereit)
- [ ] Output in `docs/agent-outputs/[issue-id].md` geschrieben

### Parallel-Arbeit mit anderen Geminis

**Wenn Claude mehrere Gemini-Instanzen startet:**
- Jede bekommt eigenen Task/Scope
- Beispiel: Gemini-1 macht iOS, Gemini-2 macht Android
- Arbeiten Sie unabhängig
- Claude koordiniert und sammelt Outputs
- Bei Konflikten: Claude entscheidet

### Best Practices

**Code-Qualität:**
- Minimale, fokussierte Änderungen
- Debug-friendly Code
- Performance nach Messung optimieren
- Keine Annahmen ohne Rückfrage

**Flutter/Dart Spezifisch:**
- l10n-Pflicht für UI-Texte: `flutter gen-l10n`
- Drift-Schema: `dart run build_runner build --delete-conflicting-outputs`
- ARB-Dateien: Alle 4 Sprachen pflegen
- Branch: `dev` → `feature/[name]`

**Kommunikation:**
- Kurz, präzise, Bullets
- Issue-ID/Plattform/Module binden
- Befehle als Code-Blöcke
- Offene Fragen explizit markieren

## File Structure Overview (from `docs/project/flutter-app-fs.md` and exploration)

The project is organized into the following main directories:

-   `lib/api`: Contains the API communication logic (`podcast_api.dart`).
-   `lib/db`: Contains the database logic, including the `AppDatabase` class and DAOs for `drift`.
-   `lib/l10n`: Contains the localization files.
-   `lib/models`: Contains the data models for the app (e.g., `Episode`, `Podcast`, `UserProfile`).
-   `lib/providers`: Contains the state management logic using `provider` (e.g., `EpisodeProvider`, `DownloadProvider`, `PodcastProvider`).
-   `lib/repositories`: Contains the repository layer for abstracting data sources (e.g., `PodcastRepository`, `ProfileRepository`).
-   `lib/screens`: Contains the UI for the different screens of the app (e.g., `home_screen`, `discover_screen`, `now_playing_screen`).
-   `lib/services`: Contains various services used by the app, such as `AudioPlayerService`, `DownloadService`, `ApiService`, and `ApiCacheService`.
-   `lib/utils`: Contains utility functions and constants (e.g., `device_id.dart`, `episode_cache_reader.dart`).
-   `integration_test`: Contains integration tests for the app.
-   `test`: Contains unit and widget tests.
-   `assets`: Contains static assets like app icons and legal documents.
-   `docs`: Contains project documentation, including workflow and file system details.
