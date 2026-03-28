# Resolved: Audio Hot-Swap Crash on Download Complete

**Status:** Resolved (2026-03-28)
**Severity:** Critical — app crash
**Platform:** Windows (just_audio_windows)
**Commit:** a985250

## Problem

When an episode was playing via remote URL and its download completed, the app
attempted a "hot-swap": stop playback → reload from local file → seek to
previous position → resume. This triggered a `just_audio_windows` crash:

```
[ERROR:flutter/shell/common/shell.cc(1183)]
The 'com.ryanheise.just_audio.events...' channel sent a message from native
to Flutter on a non-platform thread.
```

Root cause: `just_audio_windows` sends platform channel messages from a
non-platform thread when rapidly stopping and reloading audio sources.

## Solution

Removed the hot-swap logic from `EpisodeProvider.onEpisodeDownloaded()`.

**Current behavior:**

1. User taps play → episode streams from **remote URL**
2. Download completes in background → `localFilePath` is updated on the
   in-memory model only (no audio reload)
3. Playback continues uninterrupted from the remote stream
4. Next time the user plays the same episode → `playEpisode()` detects the
   local file via `cachedMetaPath` and plays from **local disk**

This is a deliberate trade-off: the user streams remotely for the remainder of
the current session, but gets local playback on every subsequent play. No crash,
no interruption.

## Affected Code

- `lib/providers/episode_provider.dart` — `onEpisodeDownloaded()`
- `lib/services/audio_player_service.dart` — `loadEpisode()` prefers local
  files when `localFilePath` is set

## Related

- `just_audio_windows` threading issue:
  https://docs.flutter.dev/platform-integration/platform-channels#channels-and-platform-threading
- Race condition fixes in same commit series: busy guard on `playEpisode()`,
  async-safe `getNextEpisode()`/`getPreviousEpisode()`
