# Klubrádió Archivum Flutter App Gemini Context

This document provides a comprehensive overview of the Klubrádió Archivum Flutter App for the Gemini AI assistant.

## Project Overview

This project is a cross-platform mobile application built with Flutter that provides a user-friendly interface to browse and play archived shows from Klubrádió. It fetches data from a Supabase backend.

### Architecture

-   **Frontend**: The application is built with Flutter.
-   **State Management**: The app uses the `provider` package for state management.
-   **Data Fetching**: It communicates with a Supabase backend via a REST API to fetch podcast and episode data. The `PodcastApi` class in `lib/api/podcast_api.dart` handles this communication.
-   **Local Storage**: The app uses `drift` (a reactive persistence library for Flutter and Dart) and `hive` for local data storage, including managing downloads and user profiles.
-   **Audio Playback**: The `just_audio` package is used for audio playback.

### Key Features (from `docs/CHECKLIST.md`)

-   **Playback**: Play audio files from the archive.
-   **Search**: Search for shows and episodes.
-   **Subscriptions**: Subscribe to shows.
-   **Auto-Download**: Automatically download new episodes of subscribed shows.
-   **Download Manager**: Manage downloaded episodes for offline listening.

## Building and Running

### Installation:

```bash
cd klubradio_archivum
flutter pub get
```

### Running the app:

```bash
flutter run
```

## Development Conventions

-   **Linting**: The project uses `flutter_lints` for code analysis and style enforcement.
-   **Internationalization**: The project uses `flutter_localizations` and `intl` for internationalization, with code generation enabled (`generate: true` in `pubspec.yaml`).
-   **Main Entry Point**: The `lib/main.dart` file is the application's entry point, responsible for initializing Hive, setting up dependency injection via `MultiProvider`, and configuring the root `MaterialApp` with themes, localizations, and the `AppShell` widget.

## File Structure Overview (from `docs/project/flutter-app-fs.md`)

The project is organized into the following main directories:

-   `lib/api`: Contains the API communication logic (`podcast_api.dart`).
-   `lib/db`: Contains the database logic, including the `AppDatabase` class and DAOs for `drift`.
-   `lib/l10n`: Contains the localization files.
-   `lib/models`: Contains the data models for the app (e.g., `Episode`, `Podcast`).
-   `lib/providers`: Contains the state management logic using `provider`.
-   `lib/repositories`: Contains the repository layer for abstracting data sources.
-   `lib/screens`: Contains the UI for the different screens of the app.
-   `lib/services`: Contains various services used by the app, such as `AudioPlayerService` and `DownloadService`.
-   `lib/utils`: Contains utility functions and constants.
-   `integration_test`: Contains integration tests for the app.
-   `test`: Contains unit and widget tests.
