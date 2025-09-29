---
title: Flutter UI Style Guide
slug: ui-style-guide
tags:
  - ui
  - style
  - design-system
  - navigation
  - settings
  - chips
  - wrap
  - localization
  - material3
version: 0.1.0
updated: 2025-09-29
---

# 🎨 UI Style Guide (Flutter · Material 3)

Single source of truth for our app’s UI. Keep this file **curated** and add each tweak to the **Changelog** below.

> **Principles**
> - Respect localization (HU/DE strings can be long).
> - Prefer Material 3 `ColorScheme` and semantic roles.
> - Components must be responsive and accessible by default.
> - No visual overflow past rounded corners.

---

## 📱 Bottom Navigation

**Component:** `AppBottomNavigationBar`

- **Structure**
    - Icons-only `NavigationBar`
    - Active destination label shown in a **top header strip** above the bar
- **Behavior**
    - Title changes via `AnimatedSwitcher` (fade + size)
    - Icon selection feedback via `AnimatedScale` + `AnimatedOpacity`
- **Theming**
    - `backgroundColor`: `colorScheme.surface`
    - `indicatorColor`: `colorScheme.primary.withOpacity(0.12)`
    - Selected icon: `colorScheme.primary`
    - Unselected icon: `colorScheme.onSurfaceVariant`
- **Layout**
    - Bar height: `60` (small screens < 600 px), else `68–72`
    - Bar clipped with `ClipRRect` and `BorderRadius.vertical(top: 16)`
    - Top divider: `BorderSide(color: outlineVariant, 0.6)`
    - `SafeArea(top: false)` to avoid double padding
- **Accessibility**
    - `tooltip` mirrors localized label for long-press hints
    - Header label: single line with ellipsis

**File(s):**
- `lib/widgets/app_bottom_navigation_bar.dart` (or equivalent)

---

## ⚙️ Settings Cards

**Components:** `ThemeSettings`, `PlaybackSettings`

- **Layout**
    - Use `Card(clipBehavior: Clip.antiAlias)`; internal `Padding(16)`
    - Titles: `textTheme.titleMedium`; section labels: `textTheme.titleSmall`
- **Controls**
    - Replace `ToggleButtons` with `ChoiceChip` inside `Wrap`
    - `Wrap(spacing: 8, runSpacing: 8)` so chips **auto-wrap** (no overflow)
- **Theming**
    - `selectedColor`: `colorScheme.primary.withOpacity(0.16)`
    - `side`: `BorderSide(primary)` when selected; else `outlineVariant .7`
    - `labelStyle`: selected → `onPrimaryContainer`, semibold; else `onSurface`
- **State**
    - Single-selection per group (speed, auto-download count, theme mode)

**File(s):**
- `lib/screens/settings/playback_settings.dart`
- `lib/screens/settings/theme_settings.dart`

---

## 🌗 General Rules

- Always derive colors from `Theme.of(context).colorScheme`
- Rounded corners: **16 px** default for bars/cards/sheets
- Never allow children to bleed past corners → set `clipBehavior`
- Respect long localized strings (use `Wrap`, `Expanded`, `ellipsis`)
- Prefer **icons + header labeling** when horizontal space is tight

---

## 🧩 Patterns to Prefer

- **Segmented choices** → `ChoiceChip` + `Wrap` (or `SegmentedButton` on wide screens)
- **Sectioned settings** → `Card` blocks with clear titles + spacing
- **Micro-interactions** → subtle scale/opacity; avoid long or bouncy animations

---

## 🧪 QA Checklist (UI)

- No overflow at 320 px width (phones) and at 1440 px (desktop)
- Long HU/DE labels don’t push icons or clip
- Focus, hover, and pressed states visible in light & dark mode
- TalkBack/VoiceOver reads labels and role correctly
- Hit targets ≥ 44×44 dp

---

## 📜 Changelog (append-only)

### 2025-09-29
- **Bottom Navigation**
    - Moved active label into a **top header strip**; bar is icons-only
    - Added `AnimatedSwitcher` for title; scale/opacity for selected icons
    - Applied `surface` background, subtle top divider, indicator tint
    - Rounded top corners (16) with clipping; responsive heights
- **Settings**
    - Replaced `ToggleButtons` with `ChoiceChip` + `Wrap` to auto-wrap
    - Unified selected state (primary tint + border); improved accessibility
    - Ensured cards clip to rounded corners to prevent bleed

---

## 🔧 How to Propose a UI Tweak

1. Write a short rationale (problem → solution).
2. Add code snippet (before/after).
3. Update relevant section above.
4. Append a dated entry to **Changelog**.
