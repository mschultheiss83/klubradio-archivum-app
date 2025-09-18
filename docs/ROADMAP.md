👌 perfekt, dann nehmen wir deine Prioritäten gleich auf.

---

# **Aktualisierte Roadmap mit Fokus auf deine Punkte**

## ✅ Sofort-Prioritäten

### 1. **Rate-Limiting (super wichtig)**

* Ziel: Pro Host max. **2 Requests / Sekunde**, um das Archiv zu schonen.
* Umsetzung in `net.make_session()`:

  * Wrapper um `requests.Session` mit `get`/`post` → Delay-Mechanismus (pro Host eigene Uhr).
  * Alternative: `requests-ratelimiter` (aber besser keine Extra-Dep, wir machen’s selbst).
  * Effekte: auch in CI / GH Actions aktiv, sodass kein „DDOS“ bei versehentlichen Massenruns.

### 2. **Docs (super wichtig, immer aktuell)**

* Struktur unter `Project_ROOT/docs/`:

  * `ARCHITECTURE.md` – Module, Flow, CI
  * `LEGAL.md` – Hinweis auf Nicht-Kommerzialität, Urheberrechte, Archivschonung
  * `APP_MVP.md` – Funktionsumfang Flutter-App
  * `CONTRIBUTING.md` – wie man Tests schreibt, Docs ergänzt, PRs macht
* Hinweis im `README`: „Das Wiki lebt von der Community – bitte beitragen.“

---

## ⚙️ Nächste Iteration (Backend/Infra)

* [ ] **Rate-Limiting in `net.py` einbauen** (Token-Bucket oder simpler Zeitstempel pro Host).
* [ ] **Tests**: künstliche Schleifen über 5 Requests, prüfen, dass mind. 2.5s vergehen.
* [ ] **Docs starten** (`docs/ARCHITECTURE.md` + `docs/LEGAL.md` als erstes).
* [ ] **CI**: Linter + Tests + Docs-Lint (z. B. `markdownlint` optional).

---

## 🚀 GitHub Actions (Zielbild)

* Scraper läuft **nur per GH Action**, nicht lokal durch CLI.
* Actions-Workflow:

  1. `lint_and_tests` (ruff + pytest + docs-check).
  2. `supabase_live` (mit Rate-Limiting aktiv).
  3. Optional: `canary`-Job, der nur 1 Archivseite lädt, um Parser-Änderungen früh zu sehen.

---

## 🔮 Community & Contributions

* `README` + `CONTRIBUTING.md`: klarer Hinweis, dass **Community-Wiki** erwünscht ist.
* GH-Wiki freigeben oder `docs/` → GitHub Pages.
* Issues/PRs willkommen für Parser-Edgecases, App-Features, Übersetzungen.

