# Projekt-Kontext & Technik

* Lokale Entwicklung, App noch nicht live; Datenbank/Build können bei Bedarf gelöscht/resetet werden (`schemaVersion` aktuell 1).
* Struktur: vollständiges `lib/`-Verzeichnis bekannt; Änderungen erfolgen strikt innerhalb dieser Struktur.
* Downloads: `background_downloader`; nach Abschluss wird **reiche Cache-JSON** (+ JPG) neben der MP3 gespeichert.
* Offline: Player bevorzugt lokale MP3 (`setFilePath`), Metadaten werden bei Verfügbarkeit aus `cachedMetaPath` gelesen.
* Subscriptions: lokale Tabelle `subscriptions` (ohne `title`), Wahrheit über `watchOne`/`watchAllActive`, Togglen via `SubscriptionsDao.toggleSubscribe`.
* DI/Provider: `AppDatabase`, `SubscriptionsDao`, Provider in `main.dart` registriert.
* Settings/Retention: UI im Download-Panel; `DownloadService` nutzt `RetentionDao` nach `complete`.

# Persistenzrichtlinie

| Kategorie                                                                                          | Empfohlene Persistenz                | Begründung                                                              |
| -------------------------------------------------------------------------------------------------- | ------------------------------------ | ----------------------------------------------------------------------- |
| **App-Einstellungen**<br>(Sprache, Theme, Wiedergabegeschwindigkeit, Auto-Downloads, App-ID u. ä.) | `SharedPreferences`                  | leichtgewichtig, sofort verfügbar, kein Overhead, keine Migration nötig |
| **Temporäre Caches**<br>(Podcast-Listen, letzte Suchergebnisse)                                    | `SharedPreferences` oder Datei-Cache | wenige KB, kein Querying erforderlich                                   |
| **Strukturierte Daten**<br>(Downloads, Episoden, Queues, Hosts, etc.)                              | lokale DB (Drift / Isar / SQLite)    | komplexe Abfragen, Joins, Indizes, große Mengen                         |
| **Netzwerk-Synchronisation**<br>(nur optional)                                                     | Supabase / API                       | nur, wenn Remote-Sync oder Telemetrie gewünscht                         |


# Arbeitsprinzipien

* **Minimal ändern, Original bewahren.**
* **Ganze Dateien liefern**, aber nur die wirklich nötigen Änderungen enthalten.
* **Standard-Loop je Schritt/Feature:**

  1. Du sendest gezielte Dateien/Infos.
  2. Ich skizziere kurz den Plan (Minimal-Patch).
  3. Nach deinem „go“ liefere ich die **komplette Datei** mit Patch.
  4. Du testest; wir iterieren.
* **Nach jedem mittel-großen Schritt** liefere ich automatisch **Offene/Nächste Punkte**.
* **Bugfix-Loop (Fehlerbehebung):**

  * Du gibst Fehlerzeile/Stack (ideal) und ggf. Screens/Dateien.
  * Ich gehe die letzten Änderungen gedanklich durch, liefere einen gezielten Fix (wieder als komplette Datei).
  * Danach zurück in den Standard-Loop.
* **l10n Pflicht** (de/en/hu); vorhandene Helper (z. B. `_statusLabel`) weiterverwenden.
* **Keine Annahmen:** Fehlen Dateien/Infos, frage ich explizit danach.
* **Sprechende Namen** (z. B. `episodeForPlay`).
* **Debug-freundlich & reversibel:** defensive Reads, keine harten Crashes.
* **Performance erst messen**, keine premature Optimierung.
* **Entscheidungsregel:** So weit wie möglich `SharedPreferences` verwenden (App-State, Settings, einfache Caches). Nur wenn Datenstruktur, Größe oder Abfragekomplexität es verlangen → lokale DB (Drift / Isar / SQLite).

# Was ich explizit von dir brauchte / noch brauchen werde

* **Gezielte Dateien** je Task (z. B. `download_list.dart`, `podcast_detail_screen.dart`, `home_screen.dart`, `app_shell.dart`, `daos.dart`, `app_database.dart`, relevante Provider/Services).
* **ARB-Dateien** für neue/angepasste l10n-Keys (de/en/hu).
* **Bestätigung** vor UI-Änderungen (Position/Komponente, Texte).
* **Screenshots/Fehlerzeilen/Logs** für die Bugfix-Phase.
* **Hinweise zu Stil/UX** (Settings-Stil, Button-Größe/Position, gewünschte Texte).
