# H5: addRecentlyPlayed Not Awaited — Research Report

**Bug ID:** H5 (from bug-scan-2026-03-26)
**Status:** Won't fix (fire-and-forget by design)
**Researched:** 2026-03-27

## Current State

`PodcastProvider.addRecentlyPlayed(Episode)` is called without `await` in three locations:

1. **`lib/screens/home_screen/recently_played_list.dart:48`** — `_EpisodeCard.onTap`
2. **`lib/screens/widgets/stateful/episode_list.dart:53`** — `EpisodeList` builder callback
3. **`lib/screens/download_manager_screen/download_list.dart:386`** — `DownloadList` builder callback

All three follow the same pattern:
```dart
onTap: () async {
  await episodeProvider.playEpisode(ep, queue: ...);
  podcastProvider.addRecentlyPlayed(ep);  // <-- not awaited
},
```

The call chain is:
- `PodcastProvider.addRecentlyPlayed()` (async, awaits ProfileProvider)
- `ProfileProvider.addRecentlyPlayed()` (async, awaits `_repo.save()`)
- `ProfileRepository.save()` (async, awaits `SharedPreferences.setString()`)

The method updates an in-memory list (dedup, insert at front, cap at 10 items), persists via SharedPreferences, and calls `notifyListeners()`.

## Risk Assessment

**Severity: Low**

### What happens on failure

1. **SharedPreferences write fails:** The in-memory `_profile` is already updated before `_repo.save()` is awaited. So even if persistence fails, the UI reflects the correct state for the current session. On next app launch, the stale data loads — the user loses one "recently played" entry.

2. **Widget disposes before completion:** The providers are not disposed when the widget is; they live at the app root via `MultiProvider` in `main.dart`. The future continues to run safely. No `BuildContext` is used after the async gap (providers read context.read before the gap).

3. **Race condition (rapid taps):** Two rapid taps could interleave the read-modify-write on `_profile`. However, Dart is single-threaded and the in-memory mutation (`removeWhere`, `insert`) happens synchronously before the `await _repo.save()`. The second tap would read the already-updated in-memory list. The only risk is two concurrent `SharedPreferences.setString` calls, which SharedPreferences handles safely (last write wins, both writes contain the correct in-memory state).

4. **Profile null:** `ProfileProvider.addRecentlyPlayed` has a null guard (`if (p == null) return`), so calling before `load()` is a silent no-op.

### Why fire-and-forget is acceptable here

- The primary action (`playEpisode`) is awaited; `addRecentlyPlayed` is a secondary side-effect
- Awaiting it would delay the user's perceived response (audio playback start) for a SharedPreferences write
- Data loss scope is minimal: at worst, one "recently played" entry is not persisted across restarts
- No downstream logic depends on `addRecentlyPlayed` completing before proceeding

## Code Paths Affected

| File | Line | Context |
|------|------|---------|
| `lib/screens/home_screen/recently_played_list.dart` | 48 | InkWell onTap in `_EpisodeCard` (StatelessWidget) |
| `lib/screens/widgets/stateful/episode_list.dart` | 53 | EpisodeListItem onTap in `EpisodeList` (StatefulWidget) |
| `lib/screens/download_manager_screen/download_list.dart` | 386 | EpisodeListItem onTap in `DownloadList` (StatefulWidget) |
| `lib/providers/podcast_provider.dart` | 236-239 | Delegates to ProfileProvider, calls notifyListeners |
| `lib/providers/profile_provider.dart` | 73-85 | In-memory update + SharedPreferences persist |
| `lib/repositories/profile_repository.dart` | 29-32 | SharedPreferences write |

## Fix Options

### Option A: Await the call (minimal change)

```dart
onTap: () async {
  await episodeProvider.playEpisode(ep, queue: ...);
  await podcastProvider.addRecentlyPlayed(ep);
},
```

**Pros:** Eliminates the unawaited future lint/warning; ensures persistence before callback returns.
**Cons:** Adds ~5-20ms latency to the tap response after playback starts (SharedPreferences write). No practical user-visible impact since playback is already started.

### Option B: Keep fire-and-forget, suppress lint

Add `// ignore: unawaited_futures` or use `unawaited()` from `dart:async` to make the intent explicit:

```dart
import 'dart:async';
// ...
unawaited(podcastProvider.addRecentlyPlayed(ep));
```

**Pros:** Documents the design intent; suppresses lint warnings cleanly.
**Cons:** Still technically unawaited; no behavior change.

### Option C: Move addRecentlyPlayed into playEpisode

Consolidate the call inside `EpisodeProvider.playEpisode()` so it is always paired with playback and awaited internally.

**Pros:** Single responsibility; callers cannot forget to call it.
**Cons:** Requires `EpisodeProvider` to depend on `PodcastProvider` or `ProfileProvider`, which may create a circular dependency given the current provider chain.

## Recommended Tests

No tests currently exercise the `addRecentlyPlayed` flow end-to-end. The existing `user_profile_test.dart` tests cover serialization of `recentlyPlayed` but not the provider logic.

Recommended additions:

1. **Unit test for `ProfileProvider.addRecentlyPlayed`:**
   - Verify deduplication (same episode ID does not create duplicates)
   - Verify max-10 cap
   - Verify most-recent-first ordering
   - Verify null profile returns silently

2. **Unit test for `PodcastProvider.addRecentlyPlayed`:**
   - Verify it delegates to ProfileProvider
   - Verify it calls notifyListeners

3. **Integration test (optional):**
   - Tap an episode, verify it appears in recently played list on home screen

## Recommendation

**Keep as fire-and-forget (Option B)** with explicit `unawaited()` wrapper.

Rationale:
- The in-memory state is updated synchronously before any await, so the UI is always correct within the session
- SharedPreferences writes are fast and reliable; failure is extremely rare
- The worst case (persistence loss on crash mid-write) loses one recently-played entry, which is trivial
- Awaiting would add unnecessary latency after playback has already started
- Provider lifecycle is app-scoped, so widget disposal does not cancel the future

The only actionable improvement is wrapping the call in `unawaited()` to make the fire-and-forget intent explicit and satisfy static analysis. Adding unit tests for the provider logic (dedup, cap, ordering) would be valuable regardless of the await decision.
