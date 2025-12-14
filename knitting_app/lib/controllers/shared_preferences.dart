// SharedPreferences nedir? Telefonun diskindeki kalıcı ayarları yönetir, basit düzeyde saklama yapabilir

// Diskle konuşan kısım burasıdır. UI ve rebuild ile işi yoktur.

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _preferences; // başına _ koyarsan değişkenlerin private oluyor

  AppPreferences({required SharedPreferences preferences})
    : _preferences = preferences;

  // KEY
  static const String _streakKey = 'streak';
  static const String _firstOpenKey = 'firstOpen';
  static const String _firstOpenAfterUpdateKey = 'firstOpenAfterUpdate';
  static const String _darkThemeKey = 'darkTheme';
  static const String _languageKey = 'language';

  // READ
  int get streak => _preferences.getInt(_streakKey) ?? 0; // diskte streak değişkeni var mı bakıyor, yoksa null dönüyor, ?? 0 ilk kurulumda default değer
  bool get firstOpening => _preferences.getBool(_firstOpenKey) ?? true;
  bool get darkTheme => _preferences.getBool(_darkThemeKey) ?? false;
  bool get firstOpenAfterUpdate =>
      _preferences.getBool(_firstOpenAfterUpdateKey) ?? false;
  String get language => _preferences.getString(_languageKey) ?? 'Turkish';

// Future ve async yapısıyla bu fonksiyonun bitmesinin zaman alacağını Flutter'a bildiririz.
  Future<void> setStreak(int value) async {
    await _preferences.setInt(_streakKey, value); // yazma bitmeden alt satıra geçme ama UI da serbest olsun
  }

  Future<void> setFirstOpening(bool value) async {
    await _preferences.setBool(_firstOpenKey, value);
  }

  Future<void> setFirstOpeningAfterUpdate(bool value) async {
    await _preferences.setBool(_firstOpenAfterUpdateKey, value);
  }

  Future<void> setDarkTheme(bool value) async {
    await _preferences.setBool(_darkThemeKey, value);
  }

  Future<void> setLanguage(String value) async {
    await _preferences.setString(_languageKey, value);
  }
}
