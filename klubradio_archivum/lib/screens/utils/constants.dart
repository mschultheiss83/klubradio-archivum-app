// lib/screens/utils/constants.dart
//
// Central configuration constants for the app.
// Grouped by domain to keep things discoverable.

// ── Supabase Table Names ──────────────────────────────────────────

const String podcastsTable = 'podcasts';
const String episodesTable = 'episodes';
const String userProfilesTable = 'user_profiles';
const String playbackEventsTable = 'playback_events';
const String topShowsTable = 'top_shows_this_year';

// ── API / Network ─────────────────────────────────────────────────

const Duration apiTimeout = Duration(seconds: 20);
const Duration apiLongTimeout = Duration(minutes: 1);
const Duration apiCacheTtl = Duration(hours: 3);
const int episodeFetchLimit = 500;
const int podcastFetchLimit = 10;
const int recentEpisodesFetchLimit = 8;
const Duration httpConnectTimeout = Duration(seconds: 5);
const Duration httpRequestTimeout = Duration(seconds: 12);
const int httpMaxRetries = 2;
const Duration httpBackoffBase = Duration(milliseconds: 300);
const Duration topShowsCacheTtl = Duration(days: 1);

// ── Search ────────────────────────────────────────────────────────

const int maxRecentSearches = 10;
const int minSearchLength = 3;
const int searchResultsLimit = 50;
const Duration searchDebounce = Duration(milliseconds: 400);

// ── Downloads & Subscriptions ─────────────────────────────────────

const int defaultAutoDownloadCount = 2;
const int defaultMaxParallel = 2;
const int maxAutoDownloadEpisodeCount = 50;
const int defaultKeepLatestN = 5;
const int defaultDeleteAfterHours = 24;
const Duration autodownloadCheckInterval = Duration(seconds: 15);

// ── Playback ──────────────────────────────────────────────────────

const List<double> playbackSpeeds = <double>[0.5, 0.75, 1.0, 1.25, 1.5];
const int maxRecentlyPlayed = 20;

// ── Episode Cache ─────────────────────────────────────────────────

const Duration episodeCacheMaxAge = Duration(minutes: 5);

// ── Images / Assets ───────────────────────────────────────────────

const String problematicEpisodeImageUrl =
    'https://www.klubradio.hu/data/sound-speaker-radio-microphone_focuspoint_340x340.jpg';
const String defaultEpisodeImageUrl = 'assets/app_icon/app_icon.png';
const String defaultPodcastImageUrl = 'assets/app_icon/app_icon.png';

// ── User / Auth ───────────────────────────────────────────────────

const String demoUserId = 'guest-user';
