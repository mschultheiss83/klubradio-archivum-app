---
tags: [docs, issues, bug, upstream, just_audio]
status: open
severity: warning
platforms: [android, ios, windows]
---

# Bug: just_audio sends events on non-platform thread

## Error

```
[ERROR:flutter/shell/common/shell.cc(1183)] The 'com.ryanheise.just_audio.events.<uuid>'
channel sent a message from native to Flutter on a non-platform thread. Platform channel
messages must be sent on the platform thread. Failure to do so may result in data loss or
crashes, and must be fixed in the plugin or application code creating that channel.
```

## Root Cause

The `just_audio` plugin (v0.10.5) sends event channel messages from a native background thread instead of the platform main thread. Per [Flutter docs](https://docs.flutter.dev/platform-integration/platform-channels#channels-and-platform-threading), all platform channel messages **must** be sent on the platform's main thread (UI thread on Android, main thread on iOS).

This is an **upstream plugin bug** — not fixable in app code.

## Impact

- Currently a warning in Flutter 3.9+
- Expected to become a **hard error** in a future Flutter version
- May cause intermittent data loss or crashes according to Flutter docs
- In practice: playback state updates may occasionally be dropped

## Current Status

- `just_audio` v0.10.5 is the latest version (as of 2026-03-26)
- No fix in the plugin's changelog
- No direct upstream issue found yet

## Action Items

- [ ] File or upvote issue on [github.com/ryanheise/just_audio](https://github.com/ryanheise/just_audio/issues)
- [ ] Monitor future `just_audio` releases for a fix
- [ ] When fixed: update `just_audio` in `pubspec.yaml` and verify the warning is gone

## Workaround

None available at the app level. The fix must happen in the plugin's native code (Android/iOS/Windows) by dispatching event channel messages on the main thread:

**Android:** `Handler(Looper.getMainLooper()).post { ... }`
**iOS:** `DispatchQueue.main.async { ... }`

## References

- [Flutter: Channels and platform threading](https://docs.flutter.dev/platform-integration/platform-channels#channels-and-platform-threading)
- Plugin: `just_audio: ^0.10.5` in `pubspec.yaml`
