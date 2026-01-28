import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeData _lightTheme = ThemeData(
    useMaterial3: true, // Material 3 tasarım kitini kullandığını belirtmek için
    //scaffoldBackgroundColor: const Color(0xFFF3E5F5), // Genel arka plan rengi
    cardTheme: CardThemeData(
      // Kart tasarımı için
      color: Colors.white,
    ),

    textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.black)),
  );

  final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
   // scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: CardThemeData(color: const Color(0xFF1E1E1E)),

    textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );

  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? _darkTheme : _lightTheme;
  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;
  // Koyu temayı doğrudan almak istersen
  ThemeData get darkTheme => _darkTheme;

  void toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
