# C5: Episode FK Constraint -- Research Report

**Bug ID:** C5 (from bug-scan-2026-03-26)
**Category:** Data Integrity / FK Violation
**Severity:** Low (currently masked), High (if FK enforcement is ever enabled)

## Current State

The `Episodes` table in `lib/db/app_database.dart` (lines 62-65) declares a custom constraint:

```dart
@override
List<String> get customConstraints => [
  'FOREIGN KEY(podcast_id) REFERENCES subscriptions(podcast_id) ON DELETE CASCADE',
];
```

This means every row in `episodes` must reference an existing row in `subscriptions`.

**FK enforcement is NOT active.** Neither the native connection (`lib/db/connection/connection_native.dart`) nor the web connection (`lib/db/connection/connection_web.dart`) issues `PRAGMA foreign_keys = ON`. SQLite defaults to `OFF`, so the FK constraint is purely declarative -- it is never checked at runtime.

No occurrence of `PRAGMA foreign_keys` or Drift's `foreignKeys` setting exists anywhere in the codebase.

## Risk Assessment

**Current risk: None.** The constraint is inert. Episodes are inserted freely regardless of whether a matching subscription exists.

**Future risk: High.** If anyone enables FK enforcement (e.g., via a Drift `setup` callback, a future Drift version default, or a `PRAGMA foreign_keys = ON` statement), the following will immediately break:

1. **Browsing any unsubscribed podcast** -- `PodcastDetailScreen.initState()` calls `loadEpisodesIntoDb()`, which upserts episodes without creating a subscription row. Every INSERT would fail with a FK constraint violation.
2. **`DownloadProvider.autoEnqueueLatestN()`** -- upserts episode rows (line 134) before calling `enqueueEpisode()`. If the episode is inserted before `enqueueEpisode` creates the subscription, the INSERT fails.

**ON DELETE CASCADE risk:** If the FK were enforced, unsubscribing (deleting a subscription row) would silently cascade-delete all episode rows for that podcast, including download metadata, progress, and local file paths. This could orphan downloaded MP3 files on disk with no DB record to clean them up.

## Code Paths Affected

### 1. `EpisodeProvider.loadEpisodesIntoDb()` -- VIOLATES FK

**File:** `lib/providers/episode_provider.dart`, lines 111-140

Called from `PodcastDetailScreen.initState()` (line 31) whenever a user opens any podcast detail page -- subscribed or not. Fetches episodes from the API and bulk-upserts them via `EpisodesDao.upsertAll()`. **No subscription row is created or checked.**

This is the primary violation path. Every podcast browse triggers it.

### 2. `DownloadProvider.autoEnqueueLatestN()` -- PARTIAL RISK

**File:** `lib/providers/download_provider.dart`, lines 116-151

Upserts an episode row (line 134) before calling `enqueueEpisode()`. The `enqueueEpisode()` in `DownloadService` does create a subscription if missing (lines 162-169), but the episode is inserted first, creating a race condition if FKs were enforced.

### 3. `DownloadService.enqueueEpisode()` -- SAFE

**File:** `lib/services/download_service.dart`, lines 160-175

This path correctly checks for and creates a subscription row before upserting the episode in `_startDownload()`. This is the only code path that handles the FK relationship properly.

### 4. `DownloadService.autodownloadPodcast()` -- SAFE

**File:** `lib/services/download_service.dart`, lines 444-481

Only runs for active subscriptions (subscription row already exists). Calls `enqueueEpisode()`, which also ensures the subscription exists.

### 5. `EpisodesDao.upsertAll()` / `EpisodesDao.upsert()` -- LOW-LEVEL

**File:** `lib/db/daos.dart`, lines 107-113

The DAO methods themselves perform no FK validation. They are called by all the paths above.

### Summary Table

| Code Path | Creates Subscription First? | Would Break with FK ON? |
|---|---|---|
| `EpisodeProvider.loadEpisodesIntoDb()` | No | Yes -- primary violator |
| `DownloadProvider.autoEnqueueLatestN()` | No (race with enqueueEpisode) | Yes -- timing dependent |
| `DownloadService.enqueueEpisode()` | Yes | No |
| `DownloadService.autodownloadPodcast()` | Yes (via enqueueEpisode) | No |

## Fix Options

### Option A: Remove the FK constraint entirely

**Changes:** Remove `customConstraints` from the `Episodes` table definition in `app_database.dart`. Bump `schemaVersion`. Run `dart run build_runner build --delete-conflicting-outputs`.

**Pros:**
- Simplest fix. Eliminates the latent bug completely.
- Episodes table genuinely does not need a strict FK relationship -- episodes are loaded for browsing purposes even when the user is not subscribed.
- No behavioral changes needed anywhere.

**Cons:**
- Loses the declarative intent that episodes belong to podcasts.
- No cascade delete if subscriptions are removed (but current code handles cleanup explicitly in the service layer anyway).

### Option B: Create passive subscription rows before upserting episodes

**Changes:** In `loadEpisodesIntoDb()`, insert a passive (inactive) subscription row if one does not exist, similar to what `DownloadService.enqueueEpisode()` does (lines 162-169).

```dart
// Before upserting episodes:
final existingSub = await SubscriptionsDao(_db).getById(podcastId);
if (existingSub == null) {
  await SubscriptionsDao(_db).upsert(
    SubscriptionsCompanion.insert(podcastId: podcastId, active: const Value(false)),
  );
}
```

Also fix the ordering in `DownloadProvider.autoEnqueueLatestN()` to call `enqueueEpisode()` before the standalone `upsert()`, or ensure subscription exists first.

**Pros:**
- Preserves the FK constraint and its ON DELETE CASCADE semantics.
- Makes the schema enforceable in the future.

**Cons:**
- Creates "phantom" subscription rows for every podcast the user browses (active=false). This pollutes the subscriptions table.
- Must handle the cascade delete side effect carefully -- unsubscribing would delete all cached episode data.
- More code changes, more places to maintain the invariant.

### Option C: Remove FK constraint + enable FK enforcement globally

**Changes:** Remove the FK constraint (Option A), then optionally enable `PRAGMA foreign_keys = ON` in the connection setup for any remaining/future FK relationships.

**Pros:**
- Clean slate. Any future FK constraints will actually be enforced.
- No phantom subscriptions.

**Cons:**
- Two changes instead of one. Must verify no other tables have FK issues.

### Option D: Keep FK constraint + enable enforcement + create passive subscriptions (Option B + enforcement)

**Changes:** Combine Option B with adding `PRAGMA foreign_keys = ON` in the connection setup.

**Pros:**
- Full data integrity. The schema is both declared and enforced.

**Cons:**
- Highest complexity. Requires careful audit of all INSERT paths.
- Phantom subscription rows.
- ON DELETE CASCADE could cause unexpected data loss.

## Recommended Tests

### Existing Tests

1. **`test/screens/subscription_download_test.dart`** (line 121-135): Documents the FK issue as a known concern. Currently a pass-through `expect(true, isTrue)` -- no actual validation.
2. **`test/db/autodownload_logic_test.dart`**: Tests auto-download preconditions against an in-memory DB. Each test creates a subscription row before inserting episodes (lines 130-140), which happens to avoid the FK issue.

### New Tests Needed

1. **FK violation test (regression/documentation):**
   - Enable `PRAGMA foreign_keys = ON` on an in-memory DB.
   - Attempt to insert an episode without a matching subscription.
   - Verify it throws a SQLite FK constraint error.
   - Purpose: Documents the exact failure mode.

2. **`loadEpisodesIntoDb` without subscription (if Option B is chosen):**
   - Call `loadEpisodesIntoDb()` for a podcast with no subscription row.
   - Verify a passive subscription row is created.
   - Verify episodes are inserted successfully.

3. **Cascade delete behavior test:**
   - Create subscription + episodes. Delete subscription.
   - Verify episodes are (or are not) cascade-deleted depending on the chosen fix.

4. **`autoEnqueueLatestN` ordering test:**
   - Verify that when `autoEnqueueLatestN` is called, the subscription row exists before any episode INSERT.

## Recommendation

**Option A: Remove the FK constraint.**

Rationale:
- The `episodes` table serves a dual purpose: it stores metadata for **browsed** episodes (any podcast) and **downloaded** episodes (typically subscribed podcasts). Tying episodes to subscriptions via FK does not match this usage pattern.
- The `DownloadService` already handles subscription creation explicitly where needed. The FK adds no safety that the service layer does not already provide.
- The ON DELETE CASCADE is actively dangerous -- it could silently destroy download records when a user unsubscribes, orphaning files on disk.
- The pre-release destructive migration strategy (drop+recreate) means the schema change carries no migration risk for current users.
- This is the smallest change with the most predictable outcome.

**Implementation steps:**
1. Remove `customConstraints` getter from the `Episodes` class in `lib/db/app_database.dart`.
2. Bump `schemaVersion` from 3 to 4.
3. Run `dart run build_runner build --delete-conflicting-outputs`.
4. Update the documentation test in `test/screens/subscription_download_test.dart` to reflect the fix.
5. Run `flutter test` and `flutter analyze` to verify.
