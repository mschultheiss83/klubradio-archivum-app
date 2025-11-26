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
-   **Workflow Principles**: Minimal changes, preserve original code, provide complete files for patches, follow a standard loop for features, and a bugfix loop for issues. `l10n` is mandatory for new/adapted keys. No assumptions are made; explicit requests for missing information. Emphasis on debug-friendly and reversible changes. Performance optimization is done after measurement. When committing changes, use `git commit --quiet` to reduce output verbosity.
-   **Git Branching for New Features**:
    When starting work on a new feature, always create a new branch from the `dev` branch.
    ```bash
    git checkout dev
    git pull origin dev
    git checkout -b feature/your-feature-name
    ```
    This ensures that your work is isolated and doesn't interfere with the main development line until it's ready to be merged.

## Task Management

Major tasks are tracked in dedicated markdown files within the `docs/project/` directory. Each task file should document the high-level goal, the implementation plan, and the current status. This allows for durable, cross-session task tracking.

To resume work, consult the relevant task file in `docs/project/` and check the current state of the codebase using `git status` and `flutter analyze`.

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
