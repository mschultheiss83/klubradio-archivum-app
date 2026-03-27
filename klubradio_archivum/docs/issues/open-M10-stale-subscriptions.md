# M10: Stale Subscriptions Panel -- Research Report

**Bug ID:** M10 from bug-scan-2026-03-26
**Status:** Was marked "won't fix" -- needs reactive stream refactor
**Severity:** Medium
**Date:** 2026-03-27

## Current State

The ProfileScreen (`lib/screens/profile_screen/profile_screen.dart`) correctly uses a `StreamBuilder` on `SubscriptionsDao.watchAllActive()` (line 86-87) to reactively listen to subscription changes from the Drift database. When the active subscriptions change in the DB, the StreamBuilder rebuilds.

**However, the actual bug is more subtle than the original scan suggested.** The StreamBuilder at lines 86-129 works in two nested stages:

1. **Outer StreamBuilder** (lines 86-103): Watches `watchAllActive()` -- this IS reactive and DOES update when subscriptions change in the DB.
2. **Inner FutureBuilder** (lines 107-128): For each active subscription ID, calls `PodcastProvider.fetchPodcastById(id)` to resolve the full `Podcast` object. This is a one-shot `FutureBuilder`.

The unsubscribe action in `SubscriptionsPanel` (line 79-87) calls `showUnsubscribeDialog()`, which calls `subscriptionProvider.toggleSubscription(podcastId, true)`. This updates the DB (sets `active: false`), which triggers the outer StreamBuilder to re-emit. So the reactive chain does exist at the ProfileScreen level.

**The real staleness problem is in `SubscriptionsPanel` itself** (lines 79-87): After the user taps "Unsubscribe" and the dialog confirms, the `showUnsubscribeDialog` function returns `true`, a SnackBar is shown, but the panel does not remove the tile from its own `podcasts` list. The panel is a `StatelessWidget` that received its `List<Podcast>` from the parent. The parent's StreamBuilder should eventually rebuild, but there is a timing/UX issue:

1. The unsubscribe dialog completes and shows a SnackBar.
2. The user sees the podcast tile still present for a moment.
3. The StreamBuilder fires and the tile disappears on the next frame.

In practice, the StreamBuilder rebuild is fast enough that this is barely noticeable. The original bug report may have been observing a different scenario where the rebuild was delayed or not triggered.

### Key Finding: The Architecture Is Already Reactive

The ProfileScreen already uses `StreamBuilder<List<db.Subscription>>` on `watchAllActive()`. The Drift `watch()` query automatically re-emits when the underlying `subscriptions` table is modified. The `toggleSubscribe` method in `SubscriptionsDao` performs an `update()` on the table, which Drift detects and propagates to active watchers.

The home screen's subscription section (lines 80-138 of `home_screen.dart`) is entirely commented out, so M10 only affects the ProfileScreen.

## Risk Assessment

**Risk Level: Low**

- The reactive stream infrastructure already exists and is wired correctly.
- `SubscriptionsDao.watchAllActive()` returns a Drift `watch()` stream that re-emits on table changes.
- `SubscriptionsDao.toggleSubscribe()` uses `update()` which triggers Drift's stream invalidation.
- The ProfileScreen already uses a `StreamBuilder` on this stream.
- The panel rebuild should happen within one frame of the DB update completing.

**Potential edge cases where staleness could occur:**
1. If `toggleSubscribe` throws before the DB update, the stream never re-emits (but error is rethrown to UI).
2. If the `FutureBuilder` inside the `StreamBuilder` caches its result and doesn't re-execute when the outer stream fires with a new value. **This is actually a real concern** -- `FutureBuilder` keeps its `AsyncSnapshot` until the `future` reference changes. Since `Future.wait(ids.map(...))` creates a new Future each time the StreamBuilder rebuilds, this should work correctly. But if the StreamBuilder emits the same list (e.g., empty list twice), the FutureBuilder won't re-trigger.

## Code Paths Affected

### Primary Files

| File | Lines | Role |
|------|-------|------|
| `lib/screens/profile_screen/profile_screen.dart` | 86-129 | StreamBuilder + FutureBuilder nesting |
| `lib/screens/profile_screen/subscriptions_panel.dart` | 8-100 | Stateless display widget, receives `List<Podcast>` |
| `lib/screens/widgets/unsubscribe_dialog.dart` | 12-45 | Dialog that calls `toggleSubscription` |
| `lib/providers/subscription_provider.dart` | 63-103 | `toggleSubscription` -- updates DB, calls `notifyListeners` |
| `lib/db/daos.dart` | 28-36 | `watchOne`, `watchAllActive` streams |
| `lib/db/daos.dart` | 46-74 | `toggleSubscribe` -- DB update that triggers stream |

### Secondary Files (not affected but related)

| File | Role |
|------|------|
| `lib/screens/home_screen/home_screen.dart` | Has commented-out subscription StreamBuilder (lines 80-138) |
| `lib/screens/home_screen/subscribed_podcasts_list.dart` | Unused widget (home screen code is commented out) |

## Fix Options

### Option A: No Fix Needed (Verify Current Behavior)

**Effort:** 1-2 hours
**Risk:** None

The architecture is already reactive. The "won't fix" label may have been premature or based on an older version of the code. Steps:

1. Add a manual test to verify: subscribe on ProfileScreen, then unsubscribe -- confirm tile disappears immediately.
2. If it works correctly, close M10 as "already fixed by existing StreamBuilder architecture."
3. Document the finding.

### Option B: Optimistic Local Removal (UX Polish)

**Effort:** 2-4 hours
**Risk:** Low

Add immediate visual feedback by removing the tile optimistically before the DB round-trip completes:

1. Convert `SubscriptionsPanel` to a `StatefulWidget` with a local `List<Podcast>` copy.
2. On unsubscribe confirmation, immediately remove the podcast from the local list and call `setState`.
3. The StreamBuilder in `ProfileScreen` will still rebuild on the next frame with the authoritative data.

This eliminates any perceived delay, even if it's only 1-2 frames.

### Option C: Full Reactive Refactor (StreamBuilder in Panel)

**Effort:** 4-8 hours
**Risk:** Medium -- changes widget contract

Move the `StreamBuilder` from `ProfileScreen` into `SubscriptionsPanel` itself:

1. Remove the `podcasts` parameter from `SubscriptionsPanel`.
2. Instead, inject `SubscriptionsDao` and `PodcastProvider` into the panel.
3. The panel internally uses `StreamBuilder<List<Subscription>>` + `FutureBuilder<List<Podcast>>`.
4. This makes the panel self-contained and reactive.

**Downside:** This duplicates the pattern already in `ProfileScreen` and couples the panel to specific providers, reducing reusability.

### Option D: Use SubscriptionProvider with notifyListeners (Provider-Based)

**Effort:** 4-6 hours
**Risk:** Medium -- adds state to SubscriptionProvider

1. Add a `List<Subscription> activeSubscriptions` field to `SubscriptionProvider`.
2. Subscribe to `watchAllActive()` in the provider's constructor.
3. `notifyListeners()` on every stream emission.
4. In `ProfileScreen`, use `context.watch<SubscriptionProvider>()` instead of a raw `StreamBuilder`.
5. The panel rebuilds via the Provider mechanism.

**Downside:** Adds memory overhead (provider holds subscription list) and complexity.

## Recommended Tests

### Existing Test Coverage

| File | Tests | Coverage |
|------|-------|---------|
| `test/providers/subscription_provider_test.dart` | 16 tests | `loadSubscription`, `watchSubscription`, `toggleSubscription` (subscribe/unsubscribe), busy flag lifecycle, `updateDependencies` |
| `test/screens/subscription_download_test.dart` | 5 doc tests | Documents subscription logic bugs (not executable widget tests) |
| `test/db/autodownload_logic_test.dart` | Multiple | Tests `watchAllActive` stream behavior with real in-memory DB |

### New Tests Needed (if implementing Option B or C)

1. **Widget test: SubscriptionsPanel removes tile after unsubscribe**
   - Mock `SubscriptionsDao` and `SubscriptionProvider`
   - Verify tile count decreases after unsubscribe action
   - *Blocked by: native plugin dependencies (same reason other widget tests are skipped)*

2. **Integration test: StreamBuilder reactivity on unsubscribe**
   - Use real in-memory Drift DB
   - Insert active subscription, verify stream emits
   - Toggle to inactive, verify stream re-emits without the subscription
   - This can be done as a pure Dart test (no widget pump needed)

3. **Unit test: watchAllActive excludes newly-deactivated subscription**
   - Already partially covered in `test/db/autodownload_logic_test.dart` (line 67)
   - Could add explicit test for the toggle-then-watch sequence

### Recommended Test (Pure Dart, No Plugins)

```dart
test('watchAllActive re-emits after toggleSubscribe deactivates', () async {
  // 1. Insert active subscription
  await subscriptionsDao.toggleSubscribe(podcastId: 'pod-1', active: true);

  // 2. Verify it appears in watchAllActive
  var subs = await subscriptionsDao.watchAllActive().first;
  expect(subs.length, 1);

  // 3. Deactivate
  await subscriptionsDao.toggleSubscribe(podcastId: 'pod-1', active: false);

  // 4. Verify it disappears from watchAllActive
  subs = await subscriptionsDao.watchAllActive().first;
  expect(subs.length, 0);
});
```

## Recommendation

**Go with Option A (verify current behavior) first.** The code already has the correct reactive architecture:

- `ProfileScreen` uses `StreamBuilder` on `watchAllActive()` (reactive Drift stream)
- `SubscriptionsDao.toggleSubscribe()` triggers Drift's stream invalidation
- The rebuild chain is: DB update -> Drift stream emission -> StreamBuilder rebuild -> new FutureBuilder with updated IDs -> SubscriptionsPanel receives new list

The bug was likely valid in an earlier version of the code before the StreamBuilder was added to `ProfileScreen`. The current implementation at lines 86-129 of `profile_screen.dart` addresses the core issue.

**If manual testing reveals any perceptible delay**, follow up with Option B (optimistic local removal) as a low-risk UX polish. Options C and D are over-engineered for this scenario.

**Estimated effort to close M10:** 1-2 hours (manual verification + optional test addition + status update in bug-scan document).
