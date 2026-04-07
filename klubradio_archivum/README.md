# klubradio_archivum

The Klubrádió Archive App is a cross-platform mobile application built with Flutter that brings the extensive archive of Klubrádió broadcasts (https://www.klubradio.hu/archivum) to users in a podcast-friendly format.

## Documentation

Use [docs/README.md](docs/README.md) as the main entry point for repository documentation.

- Current status: [docs/project/current.md](docs/project/current.md)
- Release workflow: [docs/project/release-process.md](docs/project/release-process.md)
- Task tracker: [docs/issues/tracking-major-tasks.md](docs/issues/tracking-major-tasks.md)
- Agent workflow: [docs/agents/workflow-summary.md](docs/agents/workflow-summary.md)

## Features

- **Cross-platform**: Android, iOS, macOS, Windows, Linux, Web
- **4 Languages**: Hungarian, German, English, Romanian (all validated)
- **Offline Support**: Download episodes for offline listening
- **Smart Management**: Auto-download, retention policies, WiFi-only mode
- **Modern Player**: Background playback, speed control, sleep timer

## Setup

### Prerequisites

**All platforms:**
```bash
flutter pub get
```

**Linux** — SQLite3 und MPV müssen als System-Libraries installiert sein:

| Distribution | Befehl |
|---|---|
| Ubuntu / Debian | `sudo apt install libsqlite3-dev libmpv-dev` |
| Fedora / RHEL | `sudo dnf install sqlite-devel mpv-libs-devel` |
| Arch / Manjaro | `sudo pacman -S sqlite mpv` |
| openSUSE | `sudo zypper install sqlite3-devel mpv-devel` |

- **SQLite3** wird für die Drift-Datenbank benötigt. Ohne diese Library:
  ```
  Failed to load dynamic library 'libsqlite3.so': libsqlite3.so: cannot open shared object file
  ```
- **MPV** wird für die Audiowiedergabe benötigt (`just_audio_media_kit`). Ohne MPV:
  ```
  MissingPluginException(No implementation found for method init on channel com.ryanheise.just_audio.methods)
  ```

### Known Issues (Linux)

- `just_audio` sendet Events auf einem non-platform Thread. Dies erzeugt Warnungen in der Konsole (`The '...just_audio.events...' channel sent a message on a non-platform thread`), hat aber keinen Einfluss auf die Funktionalität. Fix muss upstream im Plugin erfolgen.

- **`Non-C locale detected`** — MPV crasht bei nicht-englischen Locale-Einstellungen (Dezimaltrennzeichen-Problem). Die App verliert die Verbindung zum Device (`Lost connection to device`). Workaround:
  ```bash
  LC_NUMERIC=C flutter run -d linux
  ```

- **`lavf: Failed to create file cache`** — MPV/libavformat kann keinen Datei-Cache anlegen. Dies ist eine harmlose Warnung, die Audio-Wiedergabe funktioniert trotzdem ohne Cache. Keine Aktion erforderlich.

**Windows** — Visual Studio Build Tools mit "Desktop development with C++" Workload.

**macOS** — Xcode Command Line Tools (`xcode-select --install`).

## Update

```
flutter pub add background_downloader cupertino_icons drift hive hive_flutter html http image intl just_audio just_audio_windows markdown_widget package_info_plus path path_provider permission_handler provider shared_preferences sqlite3_flutter_libs url_launcher xml
flutter pub add --dev build_runner change_app_package_name drift_dev flutter_lints intl_translation
flutter pub add uuid device_info_plus

flutter pub get
```

### test api

`flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_service_live_test.dart`

### test download

`flutter test --dart-define DOWNLOAD_LIVE_TESTS=true .\test\integration_test\download_manager_live_test.dart`
```
flutter drive -d windows --driver=test_driver/integration_test.dart --target=integration_test/download_manager_live_test.dart --dart-define DOWNLOAD_LIVE_TESTS=true

flutter drive -d windows --driver=test_driver/integration_test.dart --target=integration_test/download_manager_live_test.dart --dart-define DOWNLOAD_LIVE_TESTS=true --dart-define DOWNLOAD_TEST_TIMEOUT_SEC=720 -v
```


### update i10n run

`flutter gen-l10n`

### app icon update

`dart run flutter_launcher_icons`

### Rebuild if DB schema changes

`dart run build_runner build --delete-conflicting-outputs`

### web build

`flutter build web --base-href "/" --wasm`

### Setup Note:
For a podcast app, ensure you configure the storage location to a directory
that is suitable for large media files and accessible to your player.

### iOS Setup (für spätere Aktivierung)

Wenn iOS-Builds genutzt werden:
1. In **Xcode → Signing & Capabilities → Background Modes** aktivieren:
    - [x] Background fetch
    - [x] Background processing
    - (optional) Audio, falls Wiedergabe im Hintergrund
2. Keine weiteren Berechtigungen nötig – background_downloader
   nutzt iOS-APIs automatisch.
3. 

### Was noch offen ist

1. **Abonnieren (Subscriptions) – lokal in DB**

   * UI: „Abonnieren“/„Deabonnieren“-Button im Podcast-Detail.
   * DB/DAO:

      * `subscriptions`-Tabelle (haben wir).
      * DAO-Methoden: `toggleSubscribe(podcastId)`, `isSubscribed(podcastId)`, `watchAll()`.
   * Auto-Download je Abo:

      * Feld `autoDownloadN` je Abo.
      * Bei neuem Abo → `enqueueLatestN(podcastId, n)`.
      * Bei App-Start (oder Pull-to-refresh) → für alle Abos prüfen/enqueuen.
   * Settings-Panel: Optional „Standard für neue Abos“ (z. B. 3 Folgen).

2. **Downloader-Feinschliff**

   * Guards testen: nach `complete` ignorieren wir spätere Events 
   * ✅ Windows Pfad/Branding: `com.example` → `de.multilevelstudios.klubradioarchivum` angepasst.

3. **Integrationstest**

   * ✅ Läuft grün, misst Größe & Speed, dynamisches Timeout.
   * kleinen Negativtest (ungültige URL ⇒ `failed`) ergänzen.
   * kleinen Negativtest (404 URL ⇒ `failed`) ergänzen.

4. **README/Onboarding**

   * Setup iOS (Xcode Permissions, Background Modes) – TODO Abschnitt.
   * Windows Build-Prereqs (VS Build Tools / Desktop C++).
   * „How to run integration tests“ (drive vs. test, Dart-defines).
   * Storage-Pfade & Retention-Regeln dokumentieren.


## Note
 
 - https://www.klubradio.hu/musorok/{podcastId}


