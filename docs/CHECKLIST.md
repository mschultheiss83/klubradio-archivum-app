# Wo wir stehen (Backend/Infra)

* ✅ **Code aufgeräumt & modularisiert**: `cache.py`, `net.py`, `parsing.py`, `mp3meta.py`, `rss_build.py` (mit feedgen-ext), `supa.py` (mit Auto-Bucket), `flow.py`, `__main__.py`.
* ✅ **Tests**: 7 grüne (Unit + Integration mit echten `cache/*.html`), Live-Supabase-Test vorbereitet (optional via Secrets).
* ✅ **Linter**: Ruff integriert, sauber.
* ✅ **CI**: Workflow vorbereitet (Lint + Tests; separater Job für Live-Supabase).
* ✅ **CLI**: `python -m klubradio_scraper --offline --upload` (für CI/Smoke).
* ✅ **Caching**: JSON + HTML-Sidecar; robust gegen Bytes/Str-Keys.
* ✅ **RSS**: RSS 2.0 + iTunes-Tags (via `feedgen-ext`).
* ☑️ **Supabase**: Auto-Bucket-Anlage drin; Tabellen-Upsert vorhanden, aber **Schema nicht versioniert**.
* ☑️ **Parser**: Funktioniert an realen Snapshots; Edge-Cases (exotische MP3-Einbettungen) teils noch ungetestet.

# Abgleich mit deiner Checklist (Kurzfassung)

## 1. Planung

* Ziele, USP, rechtliche Punkte: **in Arbeit** (noch nicht im Repo dokumentiert).
* Empfehlung: `docs/LEGAL.md` + `docs/ARCHITECTURE.md` anlegen.

## 2. Setup

* Backend fertig. **Flutter-App** noch offen.

## 3. Design

* **UI/Wireframes** fehlen (betrifft App).

## 4. Entwicklung

* ✅ Scraper + RSS ok.
* 🔜 **App-Funktionen**: Playback, Suche, Subscriptions, Auto-Download → offen.
* 🔜 **Download-Manager (mobil)** → offen.

## 5. Testing

* ✅ Backend-Unit/Integration.
* 🔜 Mobile-Tests (Widget/Integration) fehlen.
* 🔜 Monitoring/Alerting für Scraper fehlt.

## 6. Deployment

* ✅ CI für Backend.
* 🔜 Mobile Build/Release Pipelines fehlen.

## 7. Wartung

* 🔜 Site-Change-Monitoring, Versionierung des Parsers, Migrations.

# Lücken / Risiken (und Gegenmittel)

* **Recht/Policy**: Klare **Nutzungs-Notiz** und kein kommerzieller Eindruck.
  → `docs/LEGAL.md`, In-App-Disclaimer.
* **Parsing-Robustheit**: Markup kann sich ändern.
  → Snapshot-Tests per `cache/*.html` + „canary job“ in CI, der 1–2 Live-URLs parst (mit Timeout).
* **Supabase-Schema**: Kein migrationsgeführtes Schema.
  → `supabase/migrations/` mit SQL (shows-Tabelle, Indizes), `make db:push`.
* **RSS-Hosting**: Pfade/URLs finalisieren (Self-Link, CDN?).

# Konkreter Fahrplan (Milestones)

## M1 — Backend „Release-fähig“ (1–2 Tage)

1. **Supabase Schema versionieren**

   * Tabelle `shows` (mp3\_url PK/unique, title, detail\_url, show\_date, duration, hosts\[], description, created\_at).
   * SQL in `supabase/migrations/0001_init.sql`.
2. **ENV/Doku sauber**

   * `.env.example`, `README` Abschnitt „Secrets & Buckets“ (inkl. Auto-Bucket-Hinweis).
3. **CI live-Test aktivieren**

   * Secrets setzen (`SUPABASE_URL`, `SUPABASE_SERVICE_KEY`).
   * `tests/test_supabase_live.py` einchecken.

## M2 — Stabilität & Monitoring (1–2 Tage)

1. **Parser-Canaries**

   * CI-Job, der 1–2 *bekannte* Archiv-/Detailseiten live fetcht (mit 3s Timeout, Retry), nur in `main` (nicht PRs).
   * Bei Fehler: Warn-Issue aufmachen.
2. **Logging & Metrics**

   * `flow.run` → kompaktes JSON-Log (pro Show Status: ok/warn/skip).
   * Optional: kleiner Prometheus-Exporter später.

## M3 — API/Feed-Ausspielung (1 Tag)

1. **Public RSS Index**

   * Generiere zusätzlich `index.json` (Liste der letzten N Shows) in Storage.
2. **Saubere Feed-URLs**

   * `fg.link(rel="self")` auf endgültige Storage-URL (Bucket/Path) setzen.

## M4 — App-MVP (Flutter) (1–2 Wochen)

* Seiten: Home (Liste), Detail (Play), Offline (Downloads), Settings (Auto-Download N, Storage-Limit).
* Abhängigkeiten: `just_audio`, `hive`, `provider`, `path_provider`, `url_launcher`.
* **Auto-Download**: beim App-Start neueste N je Subscription laden.

# Sofort-To-Dos (P0, sehr konkret)

1. **Supabase Migration hinzufügen**

```sql
-- supabase/migrations/0001_init.sql
create table if not exists shows (
  mp3_url text primary key,
  title text,
  detail_url text,
  show_date timestamptz,
  duration integer,
  hosts text[],
  description text,
  created_at timestamptz default now()
);

create index if not exists shows_show_date_idx on shows (show_date desc);
```

– Und in `README` einen Abschnitt „DB Migrations“ (einfacher manueller Weg im Web SQL-Editor).

2. **`rss_build.py` Self-Link finalisieren**

   * `fg.link(href="https://<your-project>.supabase.co/storage/v1/object/public/<bucket>/klubradio_archive.xml", rel="self")`
   * oder dynamisch über ENV.

3. **CI Secrets setzen & Live-Test aktivieren**

   * In GitHub: Settings → Secrets → Actions → `SUPABASE_URL`, `SUPABASE_SERVICE_KEY`.
   * `tests/test_supabase_live.py` einchecken (läuft nur, wenn Secrets vorhanden).

# P1-Backlog (kurz)

* **Mehr Parser-Tests** mit seltenen Mustern (verschachtelte `<audio>`, Querystrings, Hoster-CDNs).
* **Rate-Limiting** im `net.make_session()` (z. B. pro Host 2 req/s).
* **CLI-Kommandos**: `--rebuild-rss-only`, `--max-pages`, `--since YYYY-MM-DD`.
* **Docs**: `docs/ARCHITECTURE.md`, `docs/LEGAL.md`, `docs/APP_MVP.md`.
