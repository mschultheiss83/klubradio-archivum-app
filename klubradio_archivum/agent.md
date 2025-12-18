# Agent Coordination Protocol

## Zweck & Übersicht
Koordiniert drei KI-Agenten (Claude Orchestrator, Gemini Worker, Codex Expert) zur Bearbeitung von GitHub-Issues und Tasks. Flexibles, aufgabenabhängiges Protokoll basierend auf API-Kapazität und Task-Komplexität.

## Rollenbeschreibung der Agenten

**Claude Agent (Orchestrator)**
- Wird vom User gestartet, orchestriert alle anderen Agenten
- Entscheidet welche Agenten für Task optimal sind (basierend auf Komplexität, API-Kapazität)
- Kann mehrere Gemini-Instanzen parallel starten
- Kann Codex-Instanzen bei Bedarf starten (sparsam, da kostenpflichtig)
- Kann weitere Claude-Instanzen starten falls nötig
- Prüft Test-Ergebnisse aller Agenten vor Commit
- Koordiniert Deployment via Gemini
- Architektur-Überblick und Datenfluss-Verständnis
- Nutzt Claude Code CLI Tools (Explore, Plan agents, gh-CLI)

**Gemini Agent (Primary Worker - kostenlos)**
- Haupt-Implementierung: Flutter/Dart-Code, Provider/Drift, Supabase REST
- Build/Test/Deploy Schritte ausführen
- Schema-Migrationen, Bug-Fixes, Refactoring
- Platform-specific Code (Android, iOS, macOS, Windows, Linux, Web)
- Tests erstellen und ausführen vor Commit
- Deployment durchführen (primär)
- Wird häufig eingesetzt da kostenlos
- gh-CLI Zugriff für Issues/PRs/Milestones

**Codex Agent (Expert Consultant - kostenpflichtig, sparsam nutzen)**
- Konzept-Phase: Grobes Design, strategische Entscheidungen
- Code-Review: Heavy analysis, critical thinking
- Architektur-Evaluierung: Alternative Ansätze
- Security & Performance Deep-Dive
- Wird gezielt eingesetzt, nicht als Default-Worker
- gh-CLI Zugriff

**User (Tester & Deployment Coordinator)**
- Schaut Issues an, formuliert Tasks
- Startet Claude mit Task-Beschreibung
- Testet finale Implementierung
- Deployment wenn Gemini fehlschlägt
- Registrierung, Finanzen, finale Freigabe

## Aufgabenverteilung (flexibel, aufgabenabhängig)

**Codex triggern für:**
- Neue Feature-Konzepte entwickeln
- Strategische Architektur-Entscheidungen
- Code-Review (heavy analysis)
- Critical Thinking / Challenge Annahmen
- Alternative Ansätze evaluieren

**Gemini triggern für:**
- Code-Implementierung (primär, default)
- Build/Test/Deploy Schritte
- Schema-Migrationen
- Bug-Fixes, Refactoring
- Platform-specific Code
- Kann parallel skaliert werden (mehrere Instanzen)

**Claude orchestriert:**
- Entscheidet wer was macht basierend auf Task & API-Kapazität
- Verwaltet mehrere Agent-Instanzen
- Prüft Test-Ergebnisse vor Commit-Freigabe
- Koordiniert Deployment
- Interface zum User
- Finale Qualitätssicherung

## Workflow Protocol

```
1. User schaut Issue/Task an
   ↓
2. User startet Claude (formuliert Task, gibt Context)
   ↓
3. Claude analysiert & entscheidet:
   - Task-Komplexität
   - Welche Agenten? (Gemini default, Codex bei Bedarf)
   - Parallel oder Sequential?
   - API-Kapazität (Gemini free, Codex sparsam)
   ↓
4. Claude startet Agenten:
   - Gemini-Instanz(en) für Implementierung
   - Optional: Codex für Konzept/Review
   - Optional: Weitere Claude/Gemini-Instanzen
   ↓
5. Agenten arbeiten (parallel oder sequential):
   - Code schreiben
   - Tests erstellen/erweitern
   - Lokal testen
   ↓
6. Jeder Agent validiert vor Commit:
   - flutter analyze (muss sauber sein)
   - flutter test (alle Tests müssen passen)
   - Platform-specific builds (wenn relevant)
   ↓
7. Claude prüft Ergebnisse:
   - Review Test-Outputs
   - Architektur-Compliance Check
   - Platform-Matrix Verification
   - Freigabe oder Nachbesserung
   ↓
8. Commit mit Agent-Kennung:
   - git commit -m "Message -g"  # Gemini
   - git commit -m "Message -c"  # Claude
   - git commit -m "Message -a"  # Codex
   ↓
9. Gemini führt Deployment durch:
   - Build für relevante Platformen
   - Deploy (dev/staging)
   - Smoke-Tests
   ↓
10. Falls Deployment fehlschlägt:
    - Eskalation zu User
    - User deployed manuell
    ↓
11. User testet (final):
    - Funktionale Tests
    - Platform-Tests
    - Freigabe oder Rollback
```

## Agent Communication Protocol

**Trigger-Regeln (flexibel, aufgabenabhängig):**
- Claude entscheidet basierend auf Task welche Agenten gestartet werden
- Gemini wird häufig genutzt (kostenlos, primary worker)
- Codex wird gezielt eingesetzt (kostenpflichtig, für Konzept/Review/Critical Thinking)
- Agenten können parallel arbeiten wenn Tasks unabhängig
- Agenten arbeiten sequential wenn Output des einen Input für anderen ist

**Orchestrierung durch Claude:**
- Claude kann mehrere Gemini-Instanzen parallel starten (z.B. für verschiedene Plattformen)
- Claude kann Codex bei Bedarf hinzuziehen
- Claude kann weitere Claude-Instanzen starten falls nötig
- Claude prüft alle Test-Ergebnisse vor Commit-Freigabe
- Claude koordiniert Deployment

**Zyklusvermeidung:**
- Max 2 Iterationen zwischen Agenten zum selben Punkt
- Claude entscheidet bei Wiederholung (bricht Ping-Pong ab)
- Bei Unsicherheit: Eskalation zu User

**Handoff-Indikatoren:**
Agent markiert "handoff" mit:
- Kontext (Issue-ID, Plattform, Module/Dateien)
- Annahmen
- Offene Fragen
- Empfohlene nächste Schritte
- Test-Status
- Risiken

**Eskalation zu User:**
- Fehlende Daten (Credentials, Zugriff, Toolchains)
- Breaking Changes erforderlich
- Budget/API-Limits erreicht
- Deployment fehlgeschlagen
- Unklare Requirements

**Alle Agenten haben Zugriff auf:**
- gh-CLI (Issues, PRs, Milestones lesen/schreiben)
- Codebase (lesen/schreiben)
- Build/Test Tools (flutter, dart, etc.)
- Git (commit, push mit Agent-Kennung)

## Output-Formate

**Eine Datei pro Issue/Task:**
```
docs/agent-outputs/[issue-id oder task-name].md
```

**Struktur der Datei (Bereiche pro Agent):**

```markdown
# Task: [Title] - Issue #[ID]

## Claude's Orchestration Plan
- Task analysis & breakdown
- Agent assignments
- Execution mode (parallel/sequential)
- Risk assessment
- Platform considerations

## Codex Analysis (wenn eingesetzt)
- Konzept/Design decisions
- Alternative approaches evaluated
- Architecture recommendations
- Critical review findings

## Gemini Implementation
- Code changes (files, lines)
- Build/Test commands executed
- Test results
- Platform builds verified

## Test & Validation Results
- flutter analyze: ✓/✗
- flutter test: ✓/✗ (details)
- Platform builds: ✓/✗ (per platform)

## Deployment
- Deployed by: [Gemini/User]
- Target: [dev/staging/production]
- Status: ✓/✗
- Issues: [if any]

## User Final Test
- Tested on: [platforms]
- Status: ✓/✗
- Notes: [user feedback]
```

**Commit Messages mit Agent-Kennung:**
```bash
# Format: "Beschreibung -[agent-kürzel]"
git commit -m "Add playlist feature -g"           # Gemini
git commit -m "Fix retention policy bug -g"       # Gemini
git commit -m "Review security concerns -a"       # Codex
git commit -m "Orchestrate multi-platform fix -c" # Claude
```

**Commit-Blöcke im Git-Log:**
- Agenten committen oft in zeitlichen Blöcken
- Timestamps zeigen parallel vs. sequential work
- Agent-Kennung macht Nachvollziehbarkeit leicht

## Style Guide & Best Practices

**Kommunikation:**
- Kurz, präzise, nummerierte Schritte/Bullets
- Keine Ausschmückung, direkt zum Punkt
- Jede Aussage an Issue-ID/Plattform/Modul binden
- Befehle als Codeblöcke mit klaren Flags/Paths
- Keine Vermutungen ohne Kennzeichnung
- Offene Fragen explizit markieren

**Flutter/Dart Spezifisch:**
- L10n-Pflicht bei UI-Texten: `flutter gen-l10n`
- Drift-Schema-Änderungen: `dart run build_runner build --delete-conflicting-outputs`
- ARB-Dateien: Alle 4 Sprachen (hu, de, en, ro)
- Branch-Flow: `dev` → `feature/[name]` → PR → merge

**Test & Validation Pflicht:**
- Vor jedem Commit: `flutter analyze` (muss sauber sein)
- Vor jedem Commit: `flutter test` (alle Tests grün)
- Platform-specific: relevante Builds testen
- Test-Coverage: Neue Features brauchen Tests

**Commit Convention:**
- IMMER Agent-Kennung anhängen: `-g`, `-c`, `-a`
- Keine AI-Signaturen wie "Generated with Claude Code"
- Fokussierte, klare Commit-Messages
- Beispiel: `"Fix download resume logic -g"`

**API-Kapazität Management:**
- Gemini bevorzugen (kostenlos)
- Codex gezielt einsetzen (kostenpflichtig)
- Claude kann Entscheidung an User eskalieren bei Budget-Limits

## Fehlerbehandlung

**Test-Fehlschlag vor Commit:**
1. Agent meldet Fehlschlag an Claude
2. Claude analysiert: Trivial-Fix oder komplexer?
3. Trivial: Agent fixt und re-testet
4. Komplex: Claude triggered Codex für Analysis
5. Max 2 Iterationen, dann Eskalation zu User

**Build-Fehlschlag:**
1. Agent dokumentiert Error-Output
2. Gemini attempted Fix
3. Claude reviewed Fix
4. Re-build & Re-test
5. Bei Wiederholung: Codex Code-Review
6. Bei weiterem Fehlschlag: User Eskalation

**Deployment-Fehlschlag:**
1. Gemini dokumentiert Deployment-Error
2. Claude entscheidet: Retry oder User
3. User deployed manuell falls nötig
4. Rollback bei kritischem Fehler

**API-Limit erreicht:**
1. Agent meldet Limit an Claude
2. Claude pausiert oder switched Agent (Gemini ↔ Codex)
3. User wird informiert bei Budget-Überschreitung

**Plattform-Blocker:**
1. Claude dokumentiert Blocker (z.B. Entitlements, Toolchains)
2. Gemini schlägt Workaround vor
3. Codex evaluiert falls komplex
4. User entscheidet bei Breaking Changes

**Infinite Loop Protection:**
- Max 2 Rückfragen zwischen Agenten
- Claude bricht ab und entscheidet
- Bei Unsicherheit: Eskalation zu User

## Zieldefinition

**Erfolgreiche Task-Completion:**
- Issue/Task analysiert und in ausführbare Schritte zerlegt
- Passende Agenten ausgewählt (Gemini default, Codex bei Bedarf)
- Code implementiert mit Tests
- Alle Tests bestanden (analyze + test + builds)
- Claude hat Ergebnisse geprüft und freigegeben
- Commits mit Agent-Kennung versehen (-g/-c/-a)
- Deployment erfolgreich (Gemini oder User)
- User-Tests bestanden
- Dokumentation aktualisiert (falls nötig)

**Output-Artefakte:**
- `docs/agent-outputs/[issue-id].md` mit allen Agent-Bereichen
- Git commits mit Agent-Kennungen
- Test-Ergebnisse dokumentiert
- Deployment-Status dokumentiert

**Qualitätskriterien:**
- flutter analyze: sauber
- flutter test: alle grün
- Platform-Builds: erfolgreich (relevante Plattformen)
- Architektur-Compliance: geprüft durch Claude
- User-Acceptance: bestanden

## Git-Log Analyse

### Echte Commit-Beispiele

**Claude[bot] - Architektur/Refactoring:**
```
67b7eb0 | 2025-11-12 16:16:55 | claude[bot]
feat: Implement static data bundle infrastructure and modular API refactoring

Umfang: Phase 1 (Static Data) + Phase 2 (6 neue API Klassen)
Stil: Detaillierte Message, Benefits/Next Steps
⚠️ Hatte AI-Signatur → Neue Convention: nur -c Marker
```

**Gemini-typisch - Feature-Blöcke:**
```
Session: Auto-Download (2025-11-07 21:11 - 11-08 15:48, ~18h, 8 commits)
21:11 | feat: Generate GEMINI.md...
21:40 | feat: Improve subscription logic...
22:07 | feat: Implement and refactor addRecentlyPlayed...
23:13 | feat: Implement episode download playback...
08:40 | WIP
09:32 | feat: Implement autodownload for subscribed episodes...
15:48 | feat: Implement auto-download and fix back button
15:52 | WIP

Muster: Iterativ, WIP commits, schrittweiser Aufbau
```

```
Session: Platform Migration (2025-12-12 20:23 - 12-13 02:42, ~6h, 8 commits)
20:23 | docs: Add GitHub CLI (gh) usage to GEMINI.md
20:57 | build: Remove debug print statements...
22:39 | docs: add multi-agent coordination prompt
22:43 | docs: add agent triggering guidance
23:20 | build: Enable Jetifier in gradle.properties
02:29 | test: Remove widget_test.dart and improve API service tests
02:29 | docs: Add .gemini/settings.json to .gitignore
02:29 | refactor: Remove old MainActivity.kt...

Muster: Nächtliche Session, Mix (docs/build/test/refactor)
```

```
Session: Web Deployment (2025-12-17 15:17 - 19:06, ~4h, 6 commits)
15:17 | Change app id to de.multilevelstudios.klubradioarchivum
15:24 | Enable web build and add simple web deploy scripts
15:36 | Add web deployment env template and SFTP option
16:09 | Deploy Flutter web build into /web subfolder
16:23 | Add root redirect to /web
19:06 | Add web image proxy to fix CORS issues

Muster: Schnell, iterativ, Problem-solving (CORS am Ende)
```

### Commit-Patterns

**Typen:** feat: (40%), fix: (15%), docs: (15%), build: (5%), test: (5%), refactor: (5%), WIP (10%), merges (5%)

**Zeitstempel-Muster:**
- Nächtlich (20:00-03:00): Docs, Build, Test, Refactor
- Nachmittag (14:00-19:00): Deployment, Quick Fixes
- Ganztags (12+ Stunden): Große Features mit WIP

**Agent-Blöcke:**
| Zeitblock | Dauer | Commits | Typ | Agent |
|-----------|-------|---------|-----|-------|
| 2025-11-12 16:16 | 1 Commit | 1 | Architektur-Refactoring | Claude |
| 2025-11-07 21:11 - 11-08 15:52 | ~18h | 8 | Feature (iterativ) | Gemini |
| 2025-12-12 20:23 - 12-13 02:42 | ~6h | 8 | Docs/Build/Test | Gemini |
| 2025-12-17 15:17 - 19:06 | ~4h | 6 | Web Deployment | Gemini |

### Best Practices

**Claude-Commits (Architektur):**
```bash
git commit -m "feat: [Architektur-Änderung]

[Detaillierte Beschreibung mit Phasen]

Phase 1: [Was]
- [Details]

Phase 2: [Was]
- [Details]

Benefits:
- [Vorteil 1]
- [Vorteil 2]

Next Steps:
- [Schritt 1]
- [Schritt 2]

-c"
```

**Gemini-Commits (Implementation):**
```bash
# Iterative Features
git commit -m "feat: [Feature Teil 1] -g"
git commit -m "feat: [Feature Teil 2] -g"
git commit -m "fix: [Problem] -g"

# Cleanup-Sessions
git commit -m "build: [Build-Fix] -g"
git commit -m "test: [Test-Verbesserung] -g"
git commit -m "docs: [Doku-Update] -g"
git commit -m "refactor: [Refactoring] -g"
```

**Codex-Commits (Expert Review):**
```bash
git commit -m "fix: [Security/Performance-Issue]

[Detaillierte Analyse]
[Rationale für Lösung]

-a"
```

**Anti-Patterns vermeiden:**
- ❌ AI-Signaturen ("Generated with Claude Code") → ✅ Agent-Marker (-g, -c, -a)
- ❌ Zu viele WIP ohne finale Zusammenfassung → ✅ WIP sparsam, dann finale feat:
- ❌ Unklare Messages → ✅ Klare Beschreibung (was, warum)
- ❌ Riesige Commits mit unrelated changes → ✅ Fokussiert (außer Architektur-Refactorings)

**Session-Strategien:**
- Feature-Sessions (Gemini): Start feat: → WIP optional → weitere feat: → finale feat:
- Refactoring-Sessions (Claude/Gemini): Großer Commit mit Details (Claude) ODER multiple Commits pro Modul (Gemini)
- Cleanup-Sessions (Gemini): docs/build/test/refactor in einer Session, separate Commits
