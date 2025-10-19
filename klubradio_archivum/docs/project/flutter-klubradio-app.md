hier eine kurze, saubere Übersicht — **Runtime-FS** (wo Dateien landen):


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

