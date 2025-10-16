# Checklist for Klubrádió Archive RSS App

## 1. Planning Phase
### 1.1 Define Core Objectives
- [ ] **Purpose**: Create a mobile app to access Klubrádió’s archive broadcasts, generate RSS feeds for podcast apps, provide in-app audio streaming, and automatically download the latest 5 (or configurable number) of subscribed shows for offline access.
- [ ] **Key Features**:
  - Browse and search broadcasts by title, date, host, or category (e.g., "Esti gyors", "Megbeszéljük...").
  - Generate podcast-compliant RSS feeds (RSS 2.0 with iTunes extensions) for individual shows or user-defined filters (e.g., by date or program type).
  - Stream audio directly in the app with playback controls (play, pause, seek, background playback).
  - Export RSS feeds to external podcast apps via shareable URLs or in-app subscription.
  - **Subscription and Auto-Download**:
    - Allow users to subscribe to specific shows (e.g., "Megbeszéljük...", "Hosszabbítás").
    - Automatically download the latest 5 episodes (configurable in settings, e.g., 1–10 episodes) of subscribed shows for offline access.
    - Manage downloads: Pause/resume, delete, storage limit alerts (e.g., max 1GB).
  - Offline support: Cache broadcasts, RSS feeds, and downloaded episodes for offline listening.
- [ ] **Unique Selling Points**:
  - Seamless conversion of Klubrádió’s archive into podcast-friendly RSS feeds.
  - Automatic offline access to recent episodes of subscribed shows.
  - User-friendly interface for Hungarian-speaking radio fans and podcast enthusiasts.
  - Free access, respecting Klubrádió’s policy of no payment for content.

### 1.2 Legal and Ethical Considerations
- [ ] **Content Usage**: Verify that Klubrádió’s archive is freely accessible and downloadable as stated (“hanganyagai szabadon meghallgathatók és letölthetők”). Ensure the app does not imply commercial use.
- [ ] **Scraping vs. API**:
  - Check if Klubrádió provides an official API or existing RSS feeds (e.g., via Spotify/Apple Podcast links for "Megbeszéljük..."). **Note**: Partnership/API access is currently WIP.
  - If no API exists, plan ethical HTML scraping with minimal server load (e.g., rate-limiting requests).
  - Document compliance with Klubrádió’s terms to avoid misrepresentation or fraudulent payment demands.
- [ ] **User Warnings**: Include in-app disclaimer about fake payment requests, as noted in the archive (“Amennyiben mégis ilyen kéréssel találkozik, az a Klubrádiótól független helyről érkező, hamis igény”).
- [ ] **Data Privacy**: No collection of personal data beyond basic analytics (e.g., Firebase Analytics for usage, anonymized). Comply with GDPR for EU users.
- [ ] **Licensing**: Use open-source libraries with permissive licenses (e.g., MIT, Apache). Ensure app is non-commercial or seek Klubrádió’s permission for distribution.

### 1.3 Technical Requirements
- [ ] **Platform**: Cross-platform Flutter app for iOS (min version: 12.0) and Android (min version: 7.0).
- [ ] **Data Source**:
  - Primary: Web scraping of https://www.klubradio.hu/archivum (HTML parsing to extract show details: title, date, hosts, description, audio URLs).
  - Fallback: Check for native RSS feeds or podcast APIs (e.g., Spotify/Apple Podcast endpoints).
- [ ] **RSS Generation**: Create RSS 2.0 feeds with iTunes extensions (<itunes:author>, <itunes:duration>, <enclosure> for audio). Support dynamic feeds based on user filters.
- [ ] **Audio Playback**:
  - Stream MP3s from extracted URLs (assume direct links in archive or embedded players).
  - Support background playback and lock-screen controls (iOS/Android).
- [ ] **Offline Support and Auto-Download**:
  - Cache audio files, RSS feeds, and metadata using local storage (e.g., `hive: ^2.2.3` or `sqflite` for structured data).
  - Implement download manager: 
    - Automatically download the latest 5 episodes (configurable) of subscribed shows upon app launch or when new episodes are detected.
    - Use `http` package for downloading MP3 files to device storage (e.g., app-specific directory via `path_provider`).
    - Store metadata (title, date, etc.) alongside audio for offline display.
    - Allow user to set storage limits (e.g., max 1GB) and auto-delete oldest downloads when full.
  - Permissions: Request storage permissions (Android) and handle iOS file access.
- [ ] **Performance Goals**:
  - Load archive page in <2 seconds (with decent network).
  - Generate RSS feed for 50 episodes in <1 second.
  - Download 5 episodes in <1 minute on average 4G connection.
  - Handle archives with thousands of episodes via pagination or lazy loading.

### 1.4 Target Audience Analysis
- [ ] **Primary Users**: Hungarian-speaking listeners of Klubrádió, aged 25–65, interested in news, politics, culture, and sports (e.g., "Esti gyors", "Hosszabbítás").
- [ ] **Secondary Users**: Podcast enthusiasts globally who understand Hungarian and seek archived radio content.
- [ ] **User Needs**:
  - Easy access to recent and historical broadcasts (e.g., "Megbeszéljük..." since 2002).
  - Ability to subscribe to specific shows with automatic offline access to new episodes.
  - Reliable playback with minimal buffering.
  - Search by keywords (e.g., “Bolgár György”, “sport”).
- [ ] **Accessibility**: Support screen readers, high-contrast mode, and Hungarian/English language options.

### 1.5 Scope and MVP Definition
- [ ] **MVP Features**:
  - List latest broadcasts (e.g., from 2025-09-15 to 2025-09-16, as in document).
  - Display show details: title, date, hosts, description.
  - Play audio in-app with basic controls (play/pause, seek).
  - Generate RSS feed for a single show or date range.
  - Basic search by title or date.
  - **Subscription and Auto-Download**:
    - Subscribe to shows (e.g., save show IDs locally via `hive`).
    - Automatically download the latest 5 episodes of subscribed shows on app launch (configurable in settings: 1–10 episodes).
    - Display downloaded episodes in a dedicated “Offline” section.
- [ ] **Non-MVP Features (Future)**:
  - Advanced filters (by host, category like “sport” or “politics”).
  - Advanced download management (pause/resume, queue, storage limits).
  - Push notifications for new episodes.
  - Social sharing (e.g., share episode via WhatsApp).
- [ ] **Out of Scope**:
  - Live radio streaming (focus on archive only).
  - User accounts or cloud sync (MVP uses local storage).
  - Non-Hungarian translations (except basic English UI).

### 1.6 Monetization and Sustainability
- [ ] **Model**: Free app, no ads, aligning with Klubrádió’s free access policy.
- [ ] **Optional Support**:
  - Add in-app link to donate to Klubrádió (e.g., via “Támogassa a Klubrádiót” page).
  - Add a “Donate to Developer” button:
    - Use PayPal for simplicity (widely used, supports Hungarian Forint, low setup complexity).
    - Alternative: Consider Stripe for card payments or Buy Me a Coffee for recurring support if PayPal is insufficient.
    - Implementation: Add a button in the Settings screen linking to a PayPal.me URL or Stripe checkout page (use `url_launcher` package).
    - Ensure donations are optional, clearly labeled, and separate from Klubrádió’s donation link to avoid confusion.
    - Include disclaimer: Donations support app maintenance, not content (which remains free per Klubrádió’s policy).
- [ ] **Cost Considerations**:
  - Development: Supported by different AIs for planning, coding, and testing (e.g., Grok for planning, other AI tools for code generation or debugging).
  - Hosting: Minimal (local RSS generation; optional server for feed hosting if needed).
  - Maintenance: Monitor site changes, update app for new Flutter versions.
- [ ] **Revenue Risks**:
  - Avoid monetization that conflicts with Klubrádió’s non-commercial stance.
  - Ensure “Donate to Developer” is transparent and does not imply payment for content access.

### 1.7 Stakeholder Engagement
- [ ] **Klubrádió**: Contact for partnership or API access is in progress (WIP). Continue exploring via website contact form or podcast platforms (e.g., Spotify/Apple Podcast).
- [ ] **Users**: Gather feedback via beta testing (TestFlight, Google Play Beta).
- [ ] **Community**: Promote on Hungarian forums, social media (e.g., X posts about Klubrádió).

## 2. Setup Phase
- [ ] Install Flutter SDK (latest stable, e.g., 3.13+).
- [ ] Create project: `flutter create klubradio_archive_app`.
- [ ] Add dependencies: `http`, `html`, `xml`, `just_audio`, `provider`, `hive`, `url_launcher`, `path_provider` (for downloads).
- [ ] Configure app icons, splash screen, and themes for iOS/Android.

## 3. Design Phase
- [ ] Wireframe UI: Home (show list), Show Detail (info, play, RSS), Offline (downloaded episodes), Settings (with donation buttons, download settings).
- [ ] Ensure responsive design for phones/tablets.
- [ ] UX: Infinite scroll, offline caching, accessibility (screen readers).

## 4. Development Phase
- [ ] Fetch data: Scrape archive HTML or use API if available (pending WIP confirmation).
- [ ] Generate RSS: Build XML feeds with iTunes tags.
- [ ] Audio playback: Stream MP3s with `just_audio`, support background play.
- [ ] **Auto-Download**:
  - Store subscriptions in `hive` (e.g., list of show IDs).
  - Check for new episodes on app launch (compare dates with last sync).
  - Download latest 5 episodes using `http` and save to device storage (`path_provider`).
  - Provide settings to configure number of downloads (1–10) and storage limits.
- [ ] Features: Search, filter, share RSS, cache offline, donation links.

## 5. Testing Phase
- [ ] Unit tests: Parsing, RSS generation, download logic.
- [ ] Integration tests: Data fetching, playback, auto-download functionality.
- [ ] Manual testing: iOS/Android devices, edge cases (no internet, low storage).
- [ ] Beta testing: TestFlight, Google Play Beta.

## 6. Deployment Phase
- [ ] Build: `flutter build apk`, `flutter build ipa`.
- [ ] Publish: Google Play, App Store (name: "Klubrádió Archive RSS").
- [ ] CI/CD: Optional GitHub Actions.

## 7. Maintenance Phase
- [ ] Monitor site changes: Update scraping logic as needed.
- [ ] User feedback: In-app reporting.
- [ ] Updates: Add notifications, multi-language support.



----
## update 

Visual Workflow with Supabase:

+-------------------+      (1) Runs on a schedule (e.g., every hour)
|  GitHub Actions   | -------------------------------------------------> +--------------------------+
| (Free CI/CD Runner)|                                                    |  Klubrádió Website (HTML)|
+-------------------+ <--------------------------------------------------+
       |
       | (2) Scrapes site, then writes data via Supabase API
       v
+------------------------------------+
|           Supabase Project         |
|                                    |
|  +-----------------+  +----------+ |
|  | Postgres DB     |  | Storage  | |
|  | (Stores shows)  |  | (Hosts   | |
|  |                 |  | RSS.xml) | |
|  +-----------------+  +----------+ |
+------------------------------------+
       ^           ^
       |           | (4) Flutter App reads data via API
       |           | (5) Podcast App gets feed from Storage URL
       |           |
+-------------------+
|   Flutter App     |
+-------------------+


The "Zero-Cost" Architecture with Supabase
This stack is very clean and powerful. Supabase's free tier is generous, offering a Postgres database, 1GB of file storage, and 50,000 API requests per month, which is more than enough for this project.
- Backend Logic (Scraper): GitHub Actions (Free)
- Database (Postgres): Supabase DB (Free Tier)
- API: Supabase Auto-Generated API (Included, Free)
- RSS Feed Hosting: Supabase Storage (Free Tier)