# Klubrádió Archívum – Feature Backlog

*Erstellt: 2026-03-21 | Zuletzt aktualisiert: 2026-03-22*

---

## Offene Aufgaben

### Mittlerer Aufwand

- [ ] **Lazy Loading**: Alle Listen mit **mehr als 15 Einträgen** (Schwellwert → Settings) als Lazy Loader implementieren. Prüfen welche Listen betroffen sind und ob `ListView.builder` bereits verwendet wird.

### Aufwändig

- [ ] **Podcast-spezifische Settings** (pro Podcast konfigurierbar, eigener Screen):
  - Hörrichtung (neueste / älteste zuerst) — Basis: globales `playOrder` Setting existiert jetzt
  - Anzahl der Downloads (Keep N)
  - Ungehörte Episoden löschen: ja / nein
  - Episode als gehört markieren

---

## Entscheidungen (geklärt 2026-03-21)

| Frage | Entscheidung |
|---|---|
| **Privacy-Text Sprachen** | Alle vier gleichzeitig: hu / de / en / ro |
| **"Erster Start"** | Popup bei Neuinstallation **und** nach App-Update |
| **About-Button im Header** | Auf **allen Tabs** in der AppBar (nicht nur Settings) |
| **Contributions-Quelle** | Via **GitHub** gepflegt: `assets/contributions.json` |
| **Autoplay-Reihenfolge** | Globale Einstellung, per Podcast **überschreibbar** (Hierarchie: Podcast-Setting > Global) |
| **De-Abo Popup Default** | **Keine Vorauswahl** – User muss aktiv wählen |
| **Podcast-Settings UI** | **Eigener Screen pro Podcast** |

---

## Hinweise

- Privacy/Disclaimer-Texte sind Entwürfe und werden noch verfeinert (aktuell in l10n-Dateien)
- `SettingsDao.ensureDefaults()` wird lazy aufgerufen (erst beim Öffnen von Settings/DownloadManager)
- Auto-Download bleibt bewusst "newest first" (korrekt: neueste N laden, unabhängig von Anzeige-Sortierung)

---

## Referenzen

- Settings-Screen: `lib/screens/settings_screen/`
- Download-Übersicht: `lib/screens/download_manager_screen/`
- About-Screen: `lib/screens/about_screen/`
- l10n-Dateien: `lib/l10n/` (hu, de, en, ro)
- App-ID: `hu.klubradio.archivum`
- Changelog: `CHANGELOG.md`
