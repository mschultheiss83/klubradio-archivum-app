import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB71C1C)),
        useMaterial3: true,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB71C1C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );

  void updateThemeMode(ThemeMode newMode) {
    if (_themeMode == newMode) {
      return;
    }
    _themeMode = newMode;
    notifyListeners();
  }
}
