# Quick Win #2: Theme Persistence via SharedPreferences

## Problem
Theme selection (Light/Dark/System) was only held in memory and reset to `ThemeMode.system` on every app restart.

## Solution
Extended `ThemeProvider` with SharedPreferences persistence, following the same pattern used by `ProfileRepository` for storing user preferences.

### Changes
- **`lib/providers/theme_provider.dart`**:
  - Added `SharedPreferences` import
  - Constructor calls `_loadThemeMode()` to restore saved theme on startup
  - `_loadThemeMode()` reads the `themeMode` key from SharedPreferences and parses it back to a `ThemeMode` enum value (falls back to `system` if unknown)
  - `_saveThemeMode()` writes the current theme mode name to SharedPreferences
  - Both `toggleTheme()` and `setThemeMode()` now call `_saveThemeMode()` before notifying listeners

### Design Decisions
- The constructor remains synchronous; `_loadThemeMode()` is fire-and-forget async. The app starts with `ThemeMode.system` as default and updates once SharedPreferences resolves (typically within the same frame).
- No changes needed in `lib/main.dart` since the provider initialization remains synchronous.
- SharedPreferences key: `themeMode`, storing the enum `.name` string (`system`, `light`, `dark`).

## Status
Done - not yet committed.
