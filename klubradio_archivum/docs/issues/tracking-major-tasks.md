# Tracking Issue: Major Project Tasks and Enhancements

This issue serves as a central place to track major tasks, enhancements, and known issues for the Klubrádió Archivum Flutter App. Please update this list as progress is made or new major items are identified.

### 🚀 Major Features / Enhancements

- [ ] **Subscriptions (local in DB)**
    - [x] Implement UI for "Subscribe"/"Unsubscribe" button in Podcast Detail.
    - [x] Implement DAO methods: `toggleSubscribe(podcastId)`, `isSubscribed(podcastId)`, `watchAll()`.
    - [x] Implement Auto-Download per subscription (field `autoDownloadN`).
    - [x] Implement `enqueueLatestN(podcastId, n)` for new subscriptions.
    - [x] Implement check/enqueue for all subscriptions on app start/pull-to-refresh.
    - [x] Add Settings Panel option for "Default for new subscriptions" (e.g., 3 episodes).

- [ ] **Downloader Refinements**
    - [ ] Test guards: ensure later events are ignored after `complete`.
    - [x] adapt Windows path/branding `com.example` → `de.multilevelstudios.klubradioarchivum` in docs.

### ✅ Testing Improvements

- [x] **Unit Test Suite** (2026-03-22)
    - [x] Model tests: Episode (28), Podcast (14), ShowHost (7), ShowData (4), UserProfile (10), RetentionMode (3)
    - [x] Screen utility tests: helpers (19), constants (10), PlatformUtils (5)
    - [x] Fix pre-existing test failures: mock data key mismatch, cache interference, live test skip
    - [x] Total: 140 tests passing, 0 failures
- [x] **Bug Fix: Episode._downloadStatusFromJson** (2026-03-22)
    - [x] Now accepts both `String` (from toJson/offline cache) and `int` (from DB/Drift)
    - [x] Previously crashed when loading episodes from offline JSON cache
- [x] **Code Quality: avoid_print → debugPrint** (2026-03-22)
    - [x] Replaced all `print()` with `debugPrint()` in test files
    - [x] Removed unused imports in test files
    - [x] `flutter analyze` passes with 0 issues
- [x] **Drift Web Migration** (2026-03-22)
    - [x] Migrated from deprecated `package:drift/web.dart` to `package:drift/wasm.dart`
    - [x] Added `sqlite3.wasm` (v2.9.4) and `drift_worker.js` (v2.31.0) to `web/`
    - [x] Web build succeeds (`flutter build web`)
- [ ] **Integration Tests**
    - [ ] Add small negative test for invalid URL (should result in `failed`).
    - [ ] Add small negative test for 404 URL (should result in `failed`).
- [ ] **Widget Tests**
    - [ ] Unblock screen widget tests (requires testable constructors for AudioPlayerService, DownloadProvider, AppDatabase)

### 📝 Documentation / Onboarding

- [ ] **README/Onboarding Updates**
    - [ ] Document iOS Setup (Xcode Permissions, Background Modes).
    - [ ] Document Windows Build-Prerequisites (VS Build Tools / Desktop C++).
    - [x] Document test structure and how to run tests (see CLAUDE.md)
    - [ ] Document Storage paths & Retention rules.

### 🐛 Known Issues / Bugs

- [x] **Episode offline cache crash** — `_downloadStatusFromJson` expected `int?` but `toJson()` wrote `String`. Fixed 2026-03-22.
- [x] **Subscribe button spinner forever** — Fixed in H6 (loadSubscription error handling). Fixed 2026-03-26.
- [x] **Auto-download ignores per-podcast autoDownloadN** — Fixed in L4 (0 vs null normalization). Fixed 2026-03-26.
- [x] **Deep Bug Scan (41 fixes)** — See `docs/issues/bug-scan-2026-03-26.md` for full details. Fixed 2026-03-26.
- [ ] **PodcastDetailScreen only reads local DB** — Screen uses `StreamBuilder<EpisodesDao.watchByPodcast()>` but never fetches episodes from API. First-time users see empty list.

---
**Instructions for use:**
- Check off items as they are completed.
- Add new major tasks or bugs to the relevant sections.
- Provide links to specific PRs or issues for detailed work on sub-tasks.