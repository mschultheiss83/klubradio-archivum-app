# M11: Unawaited Futures in now_playing -- Research Report

## Current State

The now_playing screen area consists of three files:
- `lib/screens/now_playing_screen/now_playing_screen.dart`
- `lib/screens/now_playing_screen/audio_player_controls.dart`
- `lib/screens/widgets/stateful/now_playing_bar.dart`

All three are `StatelessWidget`s that delegate async work to `EpisodeProvider` and `SubscriptionProvider`.
The following async methods are called from UI callbacks **without `await`**:

| Call site | Async method called | File | Line(s) |
|-----------|-------------------|------|---------|
| `onPressed` (play/pause) in `_TransportCluster` | `provider.togglePlayPause` (`Future<void>`) | `audio_player_controls.dart` | 149 |
| `onPrev` in `_TransportCluster` | `provider.playPrevious` (`Future<void>`) | `audio_player_controls.dart` | 55 |
| `onNext` in `_TransportCluster` | `provider.playNext` (`Future<void>`) | `audio_player_controls.dart` | 57 |
| `onTap` in `_SeekCluster` | `provider.seekRelative` (`Future<void>`) | `audio_player_controls.dart` | 47, 64 |
| `onChanged` in `_SpeedCluster` | `provider.updatePlaybackSpeed` (`Future<void>`) | `audio_player_controls.dart` | 69 |
| `onSeek` in `ProgressSlider` | `provider.seek` (`Future<void>`) | `progress_slider.dart` | 36 |
| `onPressed` (subscribe) in `NowPlayingScreen` | `subscriptionProvider.toggleSubscription` (`Future<void>`) | `now_playing_screen.dart` | 108-112 |
| `onPressed` (unsubscribe) in `NowPlayingScreen` | `showUnsubscribeDialog` (`Future<bool>`) | `now_playing_screen.dart` | 105-106 |
| `onPressed` (play/pause) in `NowPlayingBar` | `provider.togglePlayPause` (`Future<void>`) | `now_playing_bar.dart` | 59 |

Total: **9 unawaited async call sites** across 4 files.

## Risk Assessment

### Low Risk (true fire-and-forget)

**Audio transport controls** (`togglePlayPause`, `seek`, `seekRelative`, `playNext`, `playPrevious`, `updatePlaybackSpeed`):
- These delegate to `AudioPlayerService` which wraps `just_audio`.
- Errors from `just_audio` are already caught by the `_errorSubscription` stream listener in `EpisodeProvider`, which clears stale state and calls `notifyListeners()`.
- The UI updates reactively via `PlayerState` stream and `positionNotifier`, not via the Future's completion.
- Rapid tapping (e.g., seek +5s multiple times) works correctly because `seekRelative` updates `_positionNotifier` optimistically before awaiting the player seek.
- **Verdict: Genuinely safe fire-and-forget.** No user-visible error handling is needed beyond what the error stream already provides.

### Medium Risk

**`subscriptionProvider.toggleSubscription`** (line 108-112):
- This method performs DB writes, API calls, and triggers auto-downloads.
- Errors are caught internally and `_busy` flag is managed via try/finally.
- However, the `rethrow` at line 97 of `subscription_provider.dart` means unhandled exceptions will become **uncaught Future errors** since no one awaits the result.
- The `busy` guard prevents double-taps, mitigating race conditions.
- **Verdict: The `rethrow` is the real issue.** Since the caller never awaits, the rethrown error becomes an unhandled async error. In debug mode this prints to console; in release mode the behavior depends on `FlutterError.onError` / zone error handlers. This is the only call site that could cause a crash on some platforms.

**`showUnsubscribeDialog`** (line 105-106):
- Returns `Future<bool>` but the result is never used.
- The dialog handles its own subscription toggle internally.
- If the dialog's internal operations fail, errors propagate to the unsubscribe dialog's own error handling.
- **Verdict: Safe.** The return value is informational and unused by design.

## Code Paths Affected

```
NowPlayingScreen
  -> EpisodeProvider.togglePlayPause()     [fire-and-forget, safe]
  -> EpisodeProvider.playPrevious()        [fire-and-forget, safe]
  -> EpisodeProvider.playNext()            [fire-and-forget, safe]
  -> EpisodeProvider.seekRelative()        [fire-and-forget, safe]
  -> EpisodeProvider.seek()                [fire-and-forget, safe]
  -> EpisodeProvider.updatePlaybackSpeed() [fire-and-forget, safe]
  -> SubscriptionProvider.toggleSubscription()  [medium risk: rethrow]
  -> showUnsubscribeDialog()               [fire-and-forget, safe]

NowPlayingBar
  -> EpisodeProvider.togglePlayPause()     [fire-and-forget, safe]
```

## Fix Options

### Option A: No change (current "won't fix" stance)
- Audio controls are genuinely safe as fire-and-forget.
- The `toggleSubscription` rethrow is a latent issue but hasn't caused reported crashes.

### Option B: Targeted fix for `toggleSubscription` rethrow (recommended)
- Remove the `rethrow` in `SubscriptionProvider.toggleSubscription()` since no caller awaits it. Errors are already logged via `debugPrint`.
- Alternatively, wrap the call in `now_playing_screen.dart` to catch and display a snackbar.
- Effort: ~10 minutes, minimal risk.

### Option C: Add `unawaited()` annotations
- Import `dart:async` and wrap fire-and-forget calls with `unawaited()` to signal intent explicitly.
- This silences lint warnings (if `unawaited_futures` lint is ever enabled) and documents the design decision.
- Effort: ~15 minutes, zero functional change.

### Option D: Combination B + C
- Fix the `toggleSubscription` rethrow issue.
- Add `unawaited()` to audio control calls for documentation.
- Best of both worlds.

## Recommended Tests

No tests currently exist for the now_playing screen widgets. The test file
`test/providers/episode_provider_queue_test.dart` explicitly notes that widget tests are
skipped due to native plugin dependencies (`just_audio`, `background_downloader`).

If tests were to be added:

1. **Unit test: `toggleSubscription` error handling** -- Verify that when `subscriptionsDao.toggleSubscribe` throws, the error is caught and `busy` is reset to false without propagating an unhandled exception. This test would go in `test/providers/subscription_provider_test.dart`.

2. **Unit test: `seekRelative` optimistic update** -- Verify that calling `seekRelative` twice in rapid succession produces the correct cumulative position. Already partially covered by the optimistic update logic, but a dedicated test would confirm no race condition.

3. **Widget tests remain impractical** for these screens without mocking native audio plugins, which is the existing documented limitation.

## Recommendation

**Apply Option B only** -- remove the `rethrow` in `SubscriptionProvider.toggleSubscription()` or catch the error at the call site in `now_playing_screen.dart`.

The audio control fire-and-forget pattern is correct by design:
- The `just_audio` error stream already provides error recovery.
- UI state updates are driven by streams and `ValueNotifier`, not by Future completion.
- Optimistic updates (e.g., `seekRelative`) prevent UI lag.
- No race conditions exist because all state mutations go through `notifyListeners()`.

The `unawaited()` annotations (Option C) are nice-to-have for code clarity but provide no functional benefit and add import noise. Skip unless the `unawaited_futures` lint rule is enabled project-wide.

**Bottom line: The "won't fix" assessment is correct for 8 of 9 call sites. The `toggleSubscription` rethrow is a minor latent bug worth a one-line fix.**
