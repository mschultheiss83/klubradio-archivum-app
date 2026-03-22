# Klubrádió Archívum – Feature Backlog & Gesprächsnotizen

*Erstellt: 2026-03-21 | Zuletzt aktualisiert: 2026-03-22 | Status: Entscheidungen getroffen*

---

## 1. Datenschutz-Hinweis ("Privacy Feature")

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

## 2. Feature-Backlog (priorisiert zu klären)

### Funktionen

#### Settings
- [ ] Einstellungen tatsächlich **speichern und wirksam anwenden** (aktuell unklar ob save funktioniert)

#### Abonnements (Abo)
- [ ] **Download-Limit**: Aktuell immer 2 Downloads – soll aus den Settings übernommen werden
- [ ] **Autoplay**: Wiedergabereihenfolge konfigurierbar: neueste zuerst / älteste zuerst (nach Episoden-ID)
- [ ] **Podcast-spezifische Settings** (pro Podcast konfigurierbar):
  - Hörrichtung (neueste / älteste zuerst)
  - Anzahl der Downloads (Keep N)
  - Ungehörte Episoden löschen: ja / nein
  - Episode als gehört markieren

#### De-Abo
- [x] **Popup beim Abbestellen**: einheitlich auf Profile- und Entdecken-Screen → "Downloads behalten oder löschen?" ✅ 2026-03-22
  - Dialog aus `lib/screens/widgets/unsubscribe_dialog.dart` wird jetzt überall verwendet

#### Suche
- [x] Suche vollständig testen (Funktionalität & Edge Cases) tests schreiben ✅ 2026-03-22

#### Playlist
- [x] Aktuelle Playlist **bearbeiten** (Reihenfolge ändern, Einträge entfernen) ✅ 2026-03-22
> Wir wollen die aktuelle Playlist **bearbeiten** können (Reihenfolge ändern, Einträge entfernen) such im Code die Screens durch für die Playlist schreibe als erstes Tests dafür


#### Performance / UX
- [ ] Alle Listen mit **mehr als 15 Einträgen** (Schwellwert → Settings) als **Lazy Loader** implementieren

---

### Screens

#### About-Screen (neu)
- App-ID + Build-Nummer
- Rechtliche Infos (Impressum, Lizenz)
- Privacy Features (s. Abschnitt 1)
- Contributions (Spender ab 200 €)

#### Download-Übersicht
- Aktuelle und fertige Downloads **zusammen** anzeigen (nicht getrennt)
- Erweiterung: **"+ zur Playlist hinzufügen"** direkt aus der Übersicht
- Gruppierung: nach Podcast, neuester Download oben (wie bisher beibehalten)

---

## 3. Entscheidungen (geklärt 2026-03-21)

| Frage | Entscheidung |
|---|---|
| **Privacy-Text Sprachen** | Alle vier gleichzeitig: hu / de / en / ro |
| **"Erster Start"** | Popup bei Neuinstallation **und** nach App-Update |
| **About-Button im Header** | Auf **allen Tabs** in der AppBar (nicht nur Settings) |
| **Contributions-Quelle** | Via **GitHub** gepflegt, separates Repo/File – kommt später |
| **Autoplay-Reihenfolge** | Globale Einstellung, per Podcast **überschreibbar** (Hierarchie: Podcast-Setting > Global) |
| **De-Abo Popup Default** | **Keine Vorauswahl** – Default-Behavior beibehalten, User muss aktiv wählen |
| **Podcast-Settings UI** | **Eigener Screen pro Podcast** (empfohlenes Vorgehen) |

## 4. Noch offen

- [ ] **Lazy Loading**: Schwellwert = **15 Elemente** (konfigurierbar über Settings). Prüfen welche Listen im Code betroffen sind und ob `ListView.builder` bereits verwendet wird.
- [ ] **Contributions**: GitHub-Datei-Format und -Ort festlegen (wenn Feature umgesetzt wird)
- [ ] app icon unter linux ein binden

---

## Referenzen

- Codebase: `/home/nik/coding/klubradio-archivum-app/klubradio_archivum`
- Settings-Screen: `lib/screens/settings_screen/`
- Download-Übersicht: `lib/screens/download_manager_screen/`
- l10n-Dateien: `lib/l10n/` (hu, de, en, ro)
- App-ID: `hu.klubradio.archivum`
