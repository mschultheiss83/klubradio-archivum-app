# Klubrádió Archívum – Feature Backlog & Gesprächsnotizen

*Erstellt: 2026-03-21 | Zuletzt aktualisiert: 2026-03-22 | Status: Entscheidungen getroffen*

---

## 1. Offene Aufgaben (sortiert: Quick Wins → Aufwändig)

### Mittlerer Aufwand

- [ ] **Lazy Loading**: Alle Listen mit **mehr als 15 Einträgen** (Schwellwert → Settings) als Lazy Loader implementieren. Prüfen welche Listen betroffen sind und ob `ListView.builder` bereits verwendet wird.

### Aufwändig

- [ ] **Podcast-spezifische Settings** (pro Podcast konfigurierbar, eigener Screen):
  - Hörrichtung (neueste / älteste zuerst) — Basis: globales `playOrder` Setting existiert jetzt
  - Anzahl der Downloads (Keep N)
  - Ungehörte Episoden löschen: ja / nein
  - Episode als gehört markieren

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
| **Theme (Light/Dark)** | ✅ | ✅ | SharedPreferences (`ThemeProvider`) |

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
- [x] **App Icon unter Linux einbinden** — `linux: generate: true` in pubspec.yaml ergänzt ✅ 2026-03-22
  - Manuell noch: `dart run flutter_launcher_icons` ausführen
- [x] **Theme-Persistierung** — ThemeProvider speichert jetzt via SharedPreferences ✅ 2026-03-22
  - Key `themeMode` in SharedPreferences, async load on startup
- [x] **Download-Limit aus Settings** — Default wird aus `settings.keepLatestN` gelesen ✅ 2026-03-22
  - Fallback auf `defaultAutoDownloadCount` wenn DB leer
- [x] **Autoplay-Reihenfolge** — DB-Feld `playOrder`, UI-Toggle, `watchByPodcast()` Bug gefixt ✅ 2026-03-22
  - Schema v2→v3 Migration, ChoiceChips in Playback Settings
  - Auto-Download bleibt bewusst "newest first" (korrekt: neueste N laden)
- [x] **About-Screen + Datenschutz-Hinweis** ✅ 2026-03-22
  - Neuer About-Screen mit App-ID, Privacy-Text, Disclaimer, Contributions-Placeholder
  - Privacy-Popup beim ersten Start (pro Version, SharedPreferences)
  - Info-Button in AppBar auf allen Tabs
  - Datenschutz-Zeile in Settings
  - Texte in 4 Sprachen (hu, de, en, ro) — Entwürfe, werden noch verfeinert
- [x] **Download-Übersicht** — Active+Completed in einer Liste, "zur Playlist hinzufügen" Button ✅ 2026-03-22
  - Tabs entfernt, Section-Headers statt Tabs
  - Hardcoded deutsche Menü-Texte durch l10n ersetzt
- [x] **Contributions** — JSON-basierte Unterstützerliste im About-Screen ✅ 2026-03-22
  - `assets/contributions.json` mit Placeholder-Einträgen
  - Anzeige im About-Screen mit Empty-State

---

## Referenzen

- Codebase: `/home/nik/coding/klubradio-archivum-app/klubradio_archivum`
- Settings-Screen: `lib/screens/settings_screen/`
- Download-Übersicht: `lib/screens/download_manager_screen/`
- l10n-Dateien: `lib/l10n/` (hu, de, en, ro)
- App-ID: `hu.klubradio.archivum`
