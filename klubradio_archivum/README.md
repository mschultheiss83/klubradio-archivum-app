# klubradio_archivum

The Klubrádió Archive App is a cross-platform mobile application built with Flutter that brings the extensive archive of Klubrádió broadcasts (https://www.klubradio.hu/archivum) to users in a podcast-friendly format.

## SETUP

TODO

### test api

`flutter test --dart-define API_SERVICE_LIVE_TESTS=true .\test\services\api_service_live_test.dart`

### update i10n run

`flutter gen-l10n`

### app icon update

`dart run flutter_launcher_icons`

### Rebuild if DB schema changes
`dart run build_runner build --delete-conflicting-outputs`


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

