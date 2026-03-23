# Klubradio Archivum - Feature Backlog

*Erstellt: 2026-03-21 | Zuletzt aktualisiert: 2026-03-23*

---

## Offene Aufgaben

### Quick Win (beim naechsten Schema-Change)

- [ ] **DB-Migration aufraeumen**: Schema-Version auf 1 zuruecksetzen, alle inkrementellen Migrations (v1->v2->v3) entfernen, sauberes `onCreate`. Solange kein Release existiert, braucht kein User migriert zu werden.

### Mittlerer Aufwand

- [ ] **Lazy Loading**: Alle Listen mit **mehr als 15 Eintraegen** (Schwellwert -> Settings) als Lazy Loader implementieren. Pruefen welche Listen betroffen sind und ob `ListView.builder` bereits verwendet wird.

### Aufwaendig

- [ ] **Podcast-spezifische Settings** (pro Podcast konfigurierbar, eigener Screen):
  - Hoerrichtung (neueste / aelteste zuerst) - Basis: globales `playOrder` Setting existiert jetzt
  - Anzahl der Downloads (Keep N)
  - Ungehoerte Episoden loeschen: ja / nein
  - Episode als gehoert markieren

---

## Entscheidungen (geklaert 2026-03-21)

| Frage | Entscheidung |
|---|---|
| **Privacy-Text Sprachen** | Alle vier gleichzeitig: hu / de / en / ro |
| **"Erster Start"** | Popup bei Neuinstallation **und** nach App-Update |
| **About-Button im Header** | Auf **allen Tabs** in der AppBar (nicht nur Settings) |
| **Contributions-Quelle** | Via **GitHub** gepflegt: `assets/contributions.json` |
| **Autoplay-Reihenfolge** | Globale Einstellung, per Podcast **ueberschreibbar** (Hierarchie: Podcast-Setting > Global) |
| **De-Abo Popup Default** | **Keine Vorauswahl** - User muss aktiv waehlen |
| **Podcast-Settings UI** | **Eigener Screen pro Podcast** |

---

## Hinweise

- Privacy/Disclaimer-Texte sind Entwuerfe und werden noch verfeinert (aktuell in l10n-Dateien)
- `SettingsDao.ensureDefaults()` wird jetzt zentral beim App-Start aufgerufen; `setPlayOrder()` sichert Defaults zusaetzlich defensiv ab
- Auto-Download bleibt bewusst "newest first" (korrekt: neueste N laden, unabhaengig von Anzeige-Sortierung)

---

## Referenzen

- Settings-Screen: `lib/screens/settings_screen/`
- Download-Uebersicht: `lib/screens/download_manager_screen/`
- About-Screen: `lib/screens/about_screen/`
- l10n-Dateien: `lib/l10n/` (hu, de, en, ro)
- App-ID: `hu.klubradio.archivum`
- Changelog: `CHANGELOG.md`
