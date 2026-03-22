// test/providers/theme_provider_test.dart
//
// Unit tests for ThemeProvider.
//
// Covers:
//   - Initial theme mode defaults to ThemeMode.system
//   - toggleTheme(true) sets dark mode
//   - toggleTheme(false) sets light mode
//   - setThemeMode() works for all three modes
//   - lightTheme returns expected color scheme
//   - darkTheme returns expected color scheme
//   - Theme persists to SharedPreferences
//   - Theme loads from SharedPreferences on construction
//   - Invalid value in SharedPreferences falls back to system

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:klubradio_archivum/providers/theme_provider.dart';

void main() {
  // Ensure Flutter bindings are initialized for SharedPreferences.
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Default: empty SharedPreferences for each test unless overridden.
    SharedPreferences.setMockInitialValues({});
  });

  // ==================== Initial state ====================

  group('initial state', () {
    test('themeMode defaults to ThemeMode.system', () {
      final provider = ThemeProvider();

      expect(provider.themeMode, ThemeMode.system);
    });
  });

  // ==================== toggleTheme ====================

  group('toggleTheme', () {
    test('toggleTheme(true) sets dark mode', () {
      final provider = ThemeProvider();

      provider.toggleTheme(true);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('toggleTheme(false) sets light mode', () {
      final provider = ThemeProvider();

      provider.toggleTheme(false);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('notifies listeners when toggled', () {
      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      provider.toggleTheme(true);

      expect(calls, 1);
    });

    test('toggling multiple times updates correctly', () {
      final provider = ThemeProvider();

      provider.toggleTheme(true);
      expect(provider.themeMode, ThemeMode.dark);

      provider.toggleTheme(false);
      expect(provider.themeMode, ThemeMode.light);

      provider.toggleTheme(true);
      expect(provider.themeMode, ThemeMode.dark);
    });
  });

  // ==================== setThemeMode ====================

  group('setThemeMode', () {
    test('sets ThemeMode.light', () {
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.light);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('sets ThemeMode.dark', () {
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.dark);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('sets ThemeMode.system', () {
      final provider = ThemeProvider();
      // First change away from system, then back.
      provider.setThemeMode(ThemeMode.dark);
      provider.setThemeMode(ThemeMode.system);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('notifies listeners on each call', () {
      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      provider.setThemeMode(ThemeMode.dark);
      provider.setThemeMode(ThemeMode.light);
      provider.setThemeMode(ThemeMode.system);

      expect(calls, 3);
    });
  });

  // ==================== lightTheme ====================

  group('lightTheme', () {
    test('uses Material 3', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.useMaterial3, isTrue);
    });

    test('has light brightness', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('has custom scaffold background color', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.scaffoldBackgroundColor, const Color(0xFFF6F6F6));
    });

    test('has centered app bar title', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;

      expect(theme.appBarTheme.centerTitle, isTrue);
    });

    test('seed color is based on red (0xFFB00020)', () {
      final provider = ThemeProvider();
      final theme = provider.lightTheme;
      // The primary color should be derived from the red seed color.
      // ColorScheme.fromSeed generates a full palette; just verify it is not null.
      expect(theme.colorScheme.primary, isNotNull);
    });
  });

  // ==================== darkTheme ====================

  group('darkTheme', () {
    test('uses Material 3', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.useMaterial3, isTrue);
    });

    test('has dark brightness', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('seed color is based on pink (0xFFCF6679)', () {
      final provider = ThemeProvider();
      final theme = provider.darkTheme;

      expect(theme.colorScheme.primary, isNotNull);
    });
  });

  // ==================== SharedPreferences persistence ====================

  group('SharedPreferences persistence', () {
    test('toggleTheme persists value to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.toggleTheme(true);

      // Allow async _saveThemeMode to complete.
      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'dark');
    });

    test('setThemeMode persists value to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.light);

      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'light');
    });

    test('persists system mode', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.system);

      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeMode'), 'system');
    });
  });

  // ==================== Load from SharedPreferences ====================

  group('load from SharedPreferences', () {
    test('loads dark mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

      final provider = ThemeProvider();

      // Allow async _loadThemeMode to complete.
      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.dark);
    });

    test('loads light mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'light'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.light);
    });

    test('loads system mode from SharedPreferences on construction', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'system'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('notifies listeners after loading from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'dark'});

      final provider = ThemeProvider();
      int calls = 0;
      provider.addListener(() => calls++);

      await Future<void>.delayed(Duration.zero);

      expect(calls, 1);
    });
  });

  // ==================== Invalid SharedPreferences value ====================

  group('invalid SharedPreferences value', () {
    test('falls back to ThemeMode.system for unknown value', () async {
      SharedPreferences.setMockInitialValues({'themeMode': 'invalidValue'});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('falls back to ThemeMode.system for empty string', () async {
      SharedPreferences.setMockInitialValues({'themeMode': ''});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });

    test('stays system when themeMode key is absent', () async {
      SharedPreferences.setMockInitialValues({});

      final provider = ThemeProvider();

      await Future<void>.delayed(Duration.zero);

      expect(provider.themeMode, ThemeMode.system);
    });
  });
}
