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
    - [ ] adapt Windows path/branding `com.example` to Company/Product in `windows/runner`.

### ✅ Testing Improvements

- [ ] **Integration Tests**
    - [ ] Add small negative test for invalid URL (should result in `failed`).
    - [ ] Add small negative test for 404 URL (should result in `failed`).

### 📝 Documentation / Onboarding

- [ ] **README/Onboarding Updates**
    - [ ] Document iOS Setup (Xcode Permissions, Background Modes).
    - [ ] Document Windows Build-Prerequisites (VS Build Tools / Desktop C++).
    - [ ] Document "How to run integration tests" (drive vs. test, Dart-defines).
    - [ ] Document Storage paths & Retention rules.

### 🐛 Known Issues / Bugs

- [ ] *Add any identified bugs here.*

---
**Instructions for use:**
- Check off items as they are completed.
- Add new major tasks or bugs to the relevant sections.
- Provide links to specific PRs or issues for detailed work on sub-tasks.