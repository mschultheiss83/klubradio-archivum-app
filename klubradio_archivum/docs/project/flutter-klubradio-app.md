hier eine kurze, saubere Übersicht — **Code-FS** (lib/) und **Runtime-FS** (wo Dateien landen):

# Code-FS (Projekt)

```
lib/
├─ main.dart
├─ db/
│  ├─ app_database.dart
│  ├─ app_database.g.dart
│  ├─ daos.dart
│  └─ daos.g.dart
├─ l10n/
│  ├─ app_localizations.dart
│  ├─ app_localizations_de.dart
│  ├─ app_localizations_en.dart
│  ├─ app_localizations_hu.dart
│  └─ app_*.arb           ← deine Texte (inkl. settings_* & Hint)
├─ models/
│  ├─ episode.dart
│  ├─ podcast.dart
│  ├─ show_data.dart
│  ├─ show_host.dart
│  └─ user_profile.dart
├─ providers/
│  ├─ download_provider.dart
│  ├─ episode_provider.dart   ← spielt lokal bevorzugt + setzt Abo (idempotent)
│  ├─ podcast_provider.dart
│  └─ theme_provider.dart
├─ screens/
│  ├─ app_shell/app_shell.dart         ← Re-tap Home ⇒ reload
│  ├─ download_manager_screen/
│  │  ├─ download_manager_screen.dart
│  │  └─ download_list.dart            ← Cover aus cachedImagePath, Menü
│  ├─ podcast_detail_screen/
│  │  ├─ podcast_detail_screen.dart    ← Abo-Button in AppBar (DAO-toggle)
│  │  └─ podcast_info_card.dart
│  ├─ home_screen/
│  │  ├─ home_screen.dart              ← „Abonniert“ via watchAllActive()
│  │  └─ subscribed_podcasts_list.dart
│  ├─ discover_screen/…
│  ├─ now_playing_screen/…
│  ├─ search_screen/…
│  ├─ settings_screen/
│  │  ├─ settings_screen.dart
│  │  └─ download_settings_panel.dart  ← Retention-UI (settings_*)
│  └─ utils/
│     ├─ constants.dart
│     └─ helpers.dart                  ← formatProgress etc.
├─ screens/widgets/
│  ├─ stateful/
│  │  ├─ episode_list.dart
│  │  └─ now_playing_bar.dart
│  └─ stateless/
│     ├─ bottom_navigation_bar.dart
│     ├─ episode_list_item.dart
│     ├─ image_url.dart
│     └─ podcast_list_item.dart
├─ services/
│  ├─ api_service.dart
│  ├─ audio_player_service.dart        ← setFilePath(local) sonst setUrl
│  └─ download_service.dart            ← schreibt MP3+JSON+JPG; Retention
└─ utils/
   └─ episode_cache_reader.dart        ← robuster Reader (schemaVersion/Defaults)
```

# Runtime-FS (App-Daten)

Basisverzeichnis (plattformabhängig):

* **Windows:** `%AppData%\com.example\klubradio_archivum\`
* **macOS:** `~/Library/Application Support/com.example.klubradio_archivum/`
* **Linux:** `~/.local/share/com.example.klubradio_archivum/`

Darin legt die App (per `applicationSupport`) den Ordner **`Klubradio/`** an:

```
<app-support-dir>/
└─ Klubradio/
   └─ <podcastId>/
      ├─ <episodeId>.mp3
      ├─ <episodeId>.json     ← „reiche“ Meta (relative Pfade)
      └─ <episodeId>.jpg      ← skaliertes Cover (max ~500px)
```

DB-Datei (Drift):

```
<app-support-or-docs>/
└─ klubradio.db
```

**Mapping in der DB (episodes):**

* `local_path` → absoluter Pfad zur MP3
* `cached_meta_path` → absoluter Pfad zur JSON
* `cached_image_path` → absoluter Pfad zum JPG

so hast du den Überblick: Code da, Daten hier — und in der UI ziehen wir Cover/Meta direkt aus den gespeicherten Pfaden.

