# M12: PopupMenu Futures Not Awaited -- Research Report

## Current State

There is exactly **one `PopupMenuButton`** in the codebase, located in:

- `lib/screens/download_manager_screen/download_list.dart` (line 238)
  - Widget: `_CompletedDownloadTile`
  - The `onSelected` callback is declared `async` but its return type is consumed by Flutter's `PopupMenuButton<String>.onSelected`, which expects `void Function(String)?` -- meaning the returned `Future` is structurally discarded by the framework.

Additionally, several `ChoiceChip.onSelected` callbacks follow the same pattern (async lambdas whose futures are discarded by Flutter's `void Function(bool)?` signature):

- `lib/screens/settings_screen/playback_settings.dart` (line 52) -- playback speed selection
- `lib/screens/settings_screen/download_settings_panel.dart` (lines 123, 132, 145) -- retention mode chips
- `lib/screens/discover_screen/top_shows_list.dart` (line 29) -- FilterChip for top shows

The `_ModeChip` wrapper (download_settings_panel.dart line 203) declares `onSelected` as `VoidCallback`, which silently drops the `Future` returned by the async closures passed to it.

The `_StepperRow` onMinus/onPlus callbacks (lines 165-167) also call DAO futures (`_dao.setKeepLatestN(...)`) without await, since the callback type is `VoidCallback?`.

## Risk Assessment

### PopupMenuButton in `_CompletedDownloadTile` (PRIMARY)

Four actions in the `onSelected` switch:

| Action   | Method called                              | Returns        | Async? | Risk |
|----------|--------------------------------------------|----------------|--------|------|
| `play`   | `EpisodeProvider.playEpisode()`            | `Future<void>` | Yes    | Low  |
| `queue`  | `EpisodeProvider.addToQueue()`             | `void`          | No     | None |
| `open`   | `_openInFolder()` (local helper)           | `Future<void>` | Yes    | None |
| `delete` | `DownloadProvider.removeLocalFile()`       | `Future<void>` | Yes    | Low-Medium |

The `onTap` handler on the same `ListTile` (line 307-313) also calls `playEpisode()` without awaiting -- same fire-and-forget pattern.

**Detailed risk analysis:**

1. **`play`** -- Calls `playEpisode()` which reads cache JSON, sets audio source, and calls `notifyListeners()`. If the user navigates away or taps another action before the Future completes, the audio player state will still update correctly because `AudioPlayerService` manages its own state streams. Errors in cache reading are handled internally (null fallback). **Risk: Low.**

2. **`queue`** -- Synchronous. No issue.

3. **`open`** -- Calls `Process.run()` to open a file manager. Errors are caught and swallowed. The result is irrelevant to app state. **Risk: None.**

4. **`delete`** -- Calls `removeLocalFile()` which deletes the MP3 file and clears the DB record. If the user rapidly taps delete on multiple items, the operations are independent (different episode IDs), so no race condition. However, if delete is tapped while `play` is also in-flight for the same episode, there is a theoretical race: the file could be deleted while `playEpisode()` is trying to read it. In practice, `playEpisode()` reads the JSON metadata (not the MP3) first, and `AudioPlayerService.loadEpisode()` will fail gracefully if the MP3 is gone. **Risk: Low-Medium** -- could produce a brief error in audio playback, but no crash or data corruption.

### ChoiceChip callbacks in settings

5. **Playback speed** (playback_settings.dart:52) -- Awaits `setPlaybackSpeed()` then calls `updatePlaybackSpeed()`. The `await` inside the async lambda works correctly for sequencing those two calls. The only risk is that the outer Future is not awaited, meaning if the user rapidly toggles speeds, multiple `setPlaybackSpeed` calls could overlap. `SharedPreferences` writes are atomic, and `updatePlaybackSpeed` is synchronous, so **Risk: None** in practice.

6. **Retention mode chips** (download_settings_panel.dart:123-150) -- Two sequential DAO calls per chip (e.g., `setDeleteAfterHours(null)` then `setKeepLatestN(next)`). The `await` inside the lambda ensures sequencing. However, the `_ModeChip` declares `onSelected` as `VoidCallback`, so the Future is silently dropped. If the user taps multiple chips rapidly, the DAO calls could interleave. Since Drift serializes DB writes on the same isolate, the final state will be consistent. **Risk: Low** -- possible brief UI flicker from intermediate states.

7. **Stepper +/- buttons** (download_settings_panel.dart:165-167) -- DAO future calls returned as expressions from `VoidCallback?` lambdas. The futures are dropped. Rapid tapping could cause slight value desync, but the StreamBuilder watching the settings table will self-correct on next emission. **Risk: Low.**

### FilterChip in `top_shows_list.dart`

8. **Top shows FilterChip** (top_shows_list.dart:29) -- Awaits `fetchPodcastById()` then navigates. This is the highest-risk unawaited async: it performs a network call and navigation. However, the code correctly captures `ScaffoldMessenger` and `Navigator` before the async gap (lines 34-35), so it handles the `context.mounted` concern. The outer Future being dropped means if the widget is disposed during the fetch, the captured navigator/messenger references become stale -- but the navigation/snackbar calls will simply be no-ops or throw silently. **Risk: Low.**

## Code Paths Affected

| File | Line | Widget | Pattern |
|------|------|--------|---------|
| `download_list.dart` | 239 | `PopupMenuButton.onSelected` | `async` lambda, 3 of 4 branches call async methods |
| `download_list.dart` | 307 | `ListTile.onTap` | Calls `playEpisode()` (returns Future) without await |
| `playback_settings.dart` | 52 | `ChoiceChip.onSelected` | `async` lambda with `await` inside |
| `download_settings_panel.dart` | 123, 132, 145 | `_ModeChip.onSelected` (VoidCallback) | `async` lambda, Future silently dropped |
| `download_settings_panel.dart` | 165-167 | `_StepperRow.onMinus/onPlus` (VoidCallback?) | DAO future returned but dropped |
| `top_shows_list.dart` | 29 | `FilterChip.onSelected` | `async` lambda with network call + navigation |

## Fix Options

### Option A: Accept as fire-and-forget (current approach)

- All callbacks are inherently fire-and-forget because Flutter's widget callback signatures return `void`.
- Even if you `await` inside the lambda, the outer Future is still discarded by Flutter.
- The code already handles errors internally (try/catch in `_openInFolder`, null checks in `playEpisode`, atomic DB writes in Drift).

### Option B: Add `unawaited()` annotation for explicitness

Wrap fire-and-forget calls with `dart:async`'s `unawaited()` to signal intent:

```dart
import 'dart:async';

// Before:
onSelected: (value) async {
  context.read<EpisodeProvider>().playEpisode(m, queue: [m], preferLocal: true);
}

// After:
onSelected: (value) {
  unawaited(context.read<EpisodeProvider>().playEpisode(m, queue: [m], preferLocal: true));
}
```

This suppresses lint warnings and makes the intent explicit. However, it adds verbosity for no functional change.

### Option C: Add error handling wrappers

For the `delete` and `play` actions, wrap in a try/catch to show a SnackBar on failure:

```dart
case 'delete':
  unawaited(
    context.read<DownloadProvider>().removeLocalFile(ep.id).catchError((e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: $e')),
        );
      }
    }),
  );
  break;
```

### Option D: Fix the `VoidCallback` typing in `_ModeChip`

Change `_ModeChip.onSelected` from `VoidCallback` to `Future<void> Function()` and add `unawaited()` at the call site. This is more honest about the callback's async nature but provides no functional benefit.

## Recommended Tests

No widget tests currently exist for `_CompletedDownloadTile` or the popup menu interactions. The existing `download_list_entries_test.dart` only tests the list entry builder logic (grouping/ordering), not the tile widgets.

Widget tests for these would require mocking:
- `AppDatabase` (Drift)
- `EpisodeProvider` and `DownloadProvider` (Provider)
- `AudioPlayerService` (native plugin)

This makes them impractical as unit tests (noted in `test/screens/podcast_detail_screen_test.dart` as a known limitation).

**Feasible tests:**

1. **Provider-level tests** -- Test that `EpisodeProvider.playEpisode()` and `DownloadProvider.removeLocalFile()` handle errors gracefully (don't throw unhandled exceptions). These would validate that fire-and-forget is safe.
2. **Race condition test** -- Call `removeLocalFile()` and `playEpisode()` concurrently on the same episode ID, verify no crash or data corruption.
3. **Rapid-tap simulation** -- Call retention DAO setters in rapid succession, verify final DB state is consistent.

## Recommendation

**Agree with "won't fix" classification.** The fire-and-forget pattern is correct here for the following reasons:

1. **Flutter's callback signatures are `void`-returning by design.** Even `async` lambdas passed to `onSelected` will have their Futures dropped. This is how all Flutter apps work.

2. **All async operations handle their own errors internally.** `playEpisode()` has null fallbacks, `removeLocalFile()` catches file deletion errors, `_openInFolder()` catches process errors, DAO writes are serialized by Drift.

3. **No user-visible failure mode.** The worst case is a brief audio playback error if delete races with play on the same episode -- an unlikely user action with no data loss.

4. **The `unawaited()` wrapper (Option B) is the only change worth considering**, purely for lint suppression and code clarity. It has zero functional impact. Apply it only if the project enables the `unawaited_futures` lint rule.

**One minor improvement worth making:** The `_ModeChip.onSelected` type should arguably be `AsyncCallback` (or `Future<void> Function()`) instead of `VoidCallback` to be honest about the callback's nature. This is a cosmetic/documentation improvement only.

**Priority: P4 (cosmetic).** No functional fix needed.
