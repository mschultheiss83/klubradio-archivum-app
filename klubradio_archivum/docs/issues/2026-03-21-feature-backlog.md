# Klubrádió Archívum – Feature Backlog & Gesprächsnotizen

*Erstellt: 2026-03-21 | Zuletzt aktualisiert: 2026-03-22 | Status: Entscheidungen getroffen*

---

## 1. Offene Aufgaben (sortiert: Quick Wins → Aufwändig)

### Quick Wins

- [ ] **App Icon unter Linux einbinden**
  - *Status*: Linux fehlt komplett in `flutter_launcher_icons` Config (pubspec.yaml)
  - Android/iOS/Web/Windows/macOS sind konfiguriert, Linux nicht
  - Icon-Asset existiert bereits: `assets/app_icon/app_icon.png`
  - *Fix*: `linux: generate: true` in pubspec.yaml + `dart run flutter_launcher_icons` + ggf. CMake-Install-Rules
  - *Aufwand*: ~1h

- [ ] **Download-Limit**: Aktuell immer 2 Downloads – soll aus den Settings übernommen werden
  - *Status*: Hardcoded in `constants.dart` als `defaultAutoDownloadCount = 2`
  - DB hat bereits `autoDownloadN` (per Podcast) und `keepLatestN` (global) — beides funktioniert
  - Nur der **Default bei Abo-Erstellung** ist hardcoded (`subscription_provider.dart:67`)
  - *Fix*: Default aus Settings-DB lesen statt Konstante
  - *Aufwand*: ~30min

- [ ] **Theme-Persistierung**: ThemeProvider speichert nicht in SharedPreferences
  - *Status*: Theme (Light/Dark/System) wird nur im Memory gehalten, nach App-Restart immer System-Default
  - Playback-Speed und Sprache werden korrekt via SharedPreferences gespeichert
  - *Fix*: `ThemeProvider` um SharedPreferences-Persistierung erweitern
  - *Betroffene Dateien*: `lib/providers/theme_provider.dart`, `lib/main.dart`
  - *Aufwand*: ~30min

- [ ] **Autoplay**: Wiedergabereihenfolge konfigurierbar: neueste zuerst / älteste zuerst
  - *Status*: Überall hardcoded "newest first" — kein Setting existiert
  - Auto-Download sortiert explizit nach `publishedAt` DESC (`download_service.dart:424`)
  - `watchByPodcast()` in DAOs hat **kein** `orderBy` (undefinierte Reihenfolge!)
  - *Fix*: Neues DB-Feld `playOrder` in Settings + `orderBy` in `watchByPodcast()` + UI-Toggle
  - *Betroffene Dateien*: `app_database.dart`, `daos.dart`, `download_service.dart`, `api_service.dart`, Settings-UI
  - *Aufwand*: ~2-3h (DB-Migration + UI + alle Sortierungen anpassen)

### Mittlerer Aufwand

- [ ] **Lazy Loading**: Alle Listen mit **mehr als 15 Einträgen** (Schwellwert → Settings) als Lazy Loader implementieren. Prüfen welche Listen betroffen sind und ob `ListView.builder` bereits verwendet wird.
- [ ] **Download-Übersicht verbessern**:
  - Aktuelle und fertige Downloads **zusammen** anzeigen (nicht getrennt)
  - **"+ zur Playlist hinzufügen"** direkt aus der Übersicht
  - Gruppierung: nach Podcast, neuester Download oben (wie bisher)
- [ ] **Contributions**: GitHub-Datei-Format und -Ort festlegen (wenn Feature umgesetzt wird)

### Aufwändig

- [ ] **Podcast-spezifische Settings** (pro Podcast konfigurierbar, eigener Screen):
  - Hörrichtung (neueste / älteste zuerst)
  - Anzahl der Downloads (Keep N)
  - Ungehörte Episoden löschen: ja / nein
  - Episode als gehört markieren
- [ ] **About-Screen** (neu):
  - App-ID + Build-Nummer
  - Rechtliche Infos (Impressum, Lizenz)
  - Privacy Features (s. Abschnitt 2)
  - Contributions (Spender ab 200 €)
- [ ] **Datenschutz-Hinweis / Privacy Feature** (s. Abschnitt 2)

---

## 2. Analyse-Ergebnisse Quick Wins (2026-03-22)

### Settings: Was funktioniert, was nicht?

| Setting | Gespeichert? | Wirksam? | Speicherort |
|---------|:---:|:---:|---|
| **wifiOnly** | ✅ | ✅ | SQLite (Settings) |
| **maxParallel** | ✅ | ✅ | SQLite (Settings) |
| **deleteAfterHours** | ✅ | ✅ | SQLite (Settings) |
| **keepLatestN** | ✅ | ✅ | SQLite (Settings) |
| **autodownloadSubscribed** | ✅ | ✅ | SQLite (Settings) |
| **Playback Speed** | ✅ | ✅ | SharedPreferences (UserProfile) |
| **Sprache** | ✅ | ✅ | SharedPreferences (UserProfile) |
| **Theme (Light/Dark)** | ❌ | nur bis Restart | nur Memory (`ThemeProvider`) |

**Hinweis**: `SettingsDao.ensureDefaults()` wird lazy aufgerufen (erst beim Öffnen von Settings/DownloadManager). Wenn der User nie Settings öffnet, werden Fallback-Defaults im Code verwendet (funktioniert, aber Design-Entscheidung).

### Download-Limit: Wo steckt die "2"?

```
constants.dart:  defaultAutoDownloadCount = 2  (hardcoded)
       ↓
subscription_provider.dart:67  →  beim Abo-Erstellen als Default übergeben
       ↓
Subscriptions-Tabelle:  autoDownloadN = 2  (pro Podcast, überschreibbar)
       ↓
download_service.dart:416  →  keepN = sub.autoDownloadN ?? settings.keepLatestN ?? 0
```
→ DB-Infrastruktur existiert, nur der Einstiegspunkt ist hardcoded.

### Autoplay-Sortierung: Wo wird sortiert?

| Ort | Sortierung | Konfigurierbar? |
|-----|-----------|:---:|
| Auto-Download Queue | `publishedAt` DESC (newest) | ❌ hardcoded |
| Home "Neueste Episoden" | `publishedAt` DESC (newest) | ❌ hardcoded |
| Podcast Detail (`watchByPodcast`) | **kein orderBy** (undefiniert!) | ❌ |
| Download Manager | `updatedAt` / `completedAt` DESC | ❌ hardcoded |
| Playlist/Queue | manuelle Reihenfolge | ✅ (reorderQueue) |

---

## 3. Datenschutz-Hinweis ("Privacy Feature")

### Erster Entwurf des Textes

> **Deine Daten bleiben bei dir.**
> Diese App ist so konstruiert, dass wir technisch gar nicht in der Lage sind, persönliche Nutzungsdaten zu erfassen oder zu speichern. Es gibt keinen Account, keinen Login und keine Tracking-Infrastruktur. Alles, was du hörst, herunterlädst oder abonnierst, bleibt ausschließlich auf deinem Gerät und wird vom Server von KR direkt geladen also unterstützt diese Arbeit. Diese App dürft Ihr auch gerne unterstützen mehr unter "About"

*→ Text wird noch verfeinert.*


## Disclaimer

> Für App Absturz oder Daten-Verlust wird nicht gehaftet. und co bla.

*→ Text wird noch verfeinert.*

### UI-Umsetzung

| Wo                                                       | Was                                                     | Verhalten                                                                                 |
| -------------------------------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| **Erster App-Start** (nach Installation **oder Update**) | Popup-Dialog mit dem Datenschutz-Hinweis                | Einmalig pro Version, danach nicht mehr anzeigen (Flag in SharedPreferences, versioniert) |
| **Settings → About**                                     | Eine Zeile (z. B. *"Datenschutz & Sicherheitshinweis"*) | Klick öffnet denselben Text als Popup                                                     |
| **Alle Tab-Header (AppShell)**                           | `About`-Button rechts in der AppBar auf **jedem Tab**   | Gleiche Popup-Funktion                                                                    |

**About-Bereich in Settings:**
- Neuer Abschnitt **"About"** unterhalb der App-ID-Zeile
- Einzige sichtbare Zeile: Datenschutz-Hinweis (tap → Popup)
- Popup zeigt formatierten Text (Markdown-ähnlich, mit Überschrift + Fließtext)

---

## 4. Entscheidungen (geklärt 2026-03-21)

| Frage | Entscheidung |
|---|---|
| **Privacy-Text Sprachen** | Alle vier gleichzeitig: hu / de / en / ro |
| **"Erster Start"** | Popup bei Neuinstallation **und** nach App-Update |
| **About-Button im Header** | Auf **allen Tabs** in der AppBar (nicht nur Settings) |
| **Contributions-Quelle** | Via **GitHub** gepflegt, separates Repo/File – kommt später |
| **Autoplay-Reihenfolge** | Globale Einstellung, per Podcast **überschreibbar** (Hierarchie: Podcast-Setting > Global) |
| **De-Abo Popup Default** | **Keine Vorauswahl** – Default-Behavior beibehalten, User muss aktiv wählen |
| **Podcast-Settings UI** | **Eigener Screen pro Podcast** (empfohlenes Vorgehen) |

---

## 5. Erledigt ✅

- [x] **Suche** vollständig testen (Funktionalität & Edge Cases) tests schreiben ✅ 2026-03-22
- [x] **De-Abo Popup** beim Abbestellen: einheitlich auf allen Screens → "Downloads behalten oder löschen?" ✅ 2026-03-22
  - Dialog aus `lib/screens/widgets/unsubscribe_dialog.dart` wird jetzt überall verwendet
- [x] **Playlist bearbeiten** (Reihenfolge ändern, Einträge entfernen) ✅ 2026-03-22

---

## Referenzen

- Codebase: `/home/nik/coding/klubradio-archivum-app/klubradio_archivum`
- Settings-Screen: `lib/screens/settings_screen/`
- Download-Übersicht: `lib/screens/download_manager_screen/`
- l10n-Dateien: `lib/l10n/` (hu, de, en, ro)
- App-ID: `hu.klubradio.archivum`
