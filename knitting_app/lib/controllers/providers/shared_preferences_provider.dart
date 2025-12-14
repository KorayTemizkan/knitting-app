import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final AppPreferences _preferences;

  SharedPreferencesProvider(this._preferences);

  int get streak => _preferences.streak;
  bool get firstOpening => _preferences.firstOpening;
  bool get firstOpenAfterUpdate => _preferences.firstOpenAfterUpdate;
  bool get darkTheme => _preferences.darkTheme;
  String get language => _preferences.language;

  Future<void> toggleTheme() async {
    await _preferences.setDarkTheme(!darkTheme);
    notifyListeners();
  }

  Future<void> increaseStreak() async {
    await _preferences.setStreak(streak + 1);
    notifyListeners();
  }

  Future<void> changeLanguage(String value) async {
    await _preferences.setLanguage(value);
    notifyListeners();
  }

  Future<void> finishFirstOpening() async {
    await _preferences.setFirstOpening(false);
    notifyListeners();
  }

  Future<void> finishFirstOpenAfterUpdate() async {
    await _preferences.setFirstOpeningAfterUpdate(false);
    notifyListeners();
  }
}
