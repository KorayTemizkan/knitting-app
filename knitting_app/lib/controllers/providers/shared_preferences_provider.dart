import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  late SharedPreferences _preferences;
  final ImagePicker _picker = ImagePicker();

  SharedPreferences get preferences => _preferences;

  /// Init
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // AÇILIŞ EKRANI
  static const String _firstOpenKey = 'firstOpen';
  static const String _knowledgeLevelKey = 'knowledgeLevelKey';
  static const String _languageKey = 'language';

  // ANA SAYFA
  static const String _completedRecipeCountKey = 'completedRecipeCount';
  static const String _streakKey = 'streak';
  static const String _totalHourKey = 'totalHour';
  static const String _tigcikPointKey = 'tigcikPoint';

  // ATÖLYE

  // TOPLULUK

  // PROFİL
  static const String _userName = 'userName';
  static const String _first_name = 'firstName';
  static const String _last_name = 'lastName';
  static const String _phone = 'phone';
  static const String _createdAt = 'createdAt';

  static const String _savedRecipeIdListKey = 'savedRecipeIdList';
  static const String _likedRecipeIdListKey = 'likedRecipeIdList';

  static const String _savedHowToIdList = 'savedHowToIdList';
  static const String _likedHowToIdList = 'likedHowToIdList';

  static const String _savedKnittingCafeIdList = 'savedKnittingCafeIdList';
  static const String _likedKnittingCafeIdList = 'likedKnittingCafeIdList';

  // AYARLAR
  static const String _firstOpenAfterUpdateKey = 'firstOpenAfterUpdate';
  static const String _darkThemeKey = 'darkTheme';
  static const String _profilePhotoFilePathKey = 'profilePhotoFilePath';

  // UI için okuma
  int get streak => _preferences.getInt(_streakKey) ?? 0;
  bool get darkTheme => _preferences.getBool(_darkThemeKey) ?? false;
  bool get isFirstOpen => _preferences.getBool(_firstOpenKey) ?? true;
  String get profilePhoto =>
      _preferences.getString(_profilePhotoFilePathKey) ?? '';
  String get firstName => _preferences.getString(_first_name) ?? '';
  String get lastName => _preferences.getString(_last_name) ?? '';
  String get phone => _preferences.getString(_phone) ?? '';
  String get createdAt => _preferences.getString(_createdAt) ?? '';

  // *****************************************************************************

  // AÇILIŞ EKRANI

  // İlk açılışı geçtiğimizi haber vermek
  Future<void> setFirstOpening() async {
    await _preferences.setBool(_firstOpenKey, false);
    notifyListeners();
  }

  // İlk açılış ekranında bilgi düzeyini ayarlamak, ileride eğitime göre bir üst düzeye çıkartabiliriz
  Future<void> setKnowledgeLevel(String value) async {
    await _preferences.setString(_knowledgeLevelKey, value);
    notifyListeners();
  }

  // Dili Türkçe-Azerbaycan Dili-İngilizce arasında değiştirmek
  Future<void> setLanguage(String value) async {
    await _preferences.setString(_languageKey, value);
    notifyListeners();
  }

  // *****************************************************************************

  // ANA SAYFA

  // Her gün streak'i 1 arttırmak (xp ödülü yok çünkü kolayca manipüle edilebilir)
  Future<void> increaseStreak() async {
    int count = _preferences.getInt(_streakKey) ?? 0;
    await _preferences.setInt(_streakKey, count + 1);
    notifyListeners();
  }

  Future<void> increaseTigcikPoint(int value) async {
    int count = _preferences.getInt(_tigcikPointKey) ?? 0;
    await _preferences.setInt(_tigcikPointKey, count += value);
  }

  Future<void> increaseTotalHour(int value) async {
    int count = _preferences.getInt(_totalHourKey) ?? 0;
    await _preferences.setInt(_totalHourKey, count += value);
  }

  Future<void> completedRecipeCount() async {
    int count = _preferences.getInt(_completedRecipeCountKey) ?? 0;
    await _preferences.setInt(_completedRecipeCountKey, count + 1);
  }

  // *****************************************************************************

  // ATÖLYE

  Future<void> increaseCompletedRecipeCount() async {
    final count = _preferences.getInt(_completedRecipeCountKey) ?? 0;
    await _preferences.setInt(_completedRecipeCountKey, count + 1);
    notifyListeners();
  }

  // *****************************************************************************

  // TOPLULUK

  // *****************************************************************************

  // PROFİL AYARLARI

  // Kişisel Bilgileri kaydetme ve beğenme

  Future<void> setUserName(String value) async {
    await _preferences.setString(_userName, value);
    notifyListeners();
  }

  Future<void> setFirstName(String value) async {
    await _preferences.setString(_first_name, value);
    notifyListeners();
  }

  Future<void> setLastName(String value) async {
    await _preferences.setString(_last_name, value);
    notifyListeners();
  }

  Future<void> setPhone(String value) async {
    await _preferences.setString(_phone, value);
    notifyListeners();
  }

  Future<void> setCreatedAt(String value) async {
    await _preferences.setString(_createdAt, value);
    notifyListeners();
  }

  // Tarifleri kaydetme ve beğenme

  List<String> get savedRecipes =>
      _preferences.getStringList(_savedRecipeIdListKey) ?? [];

  Future<void> saveRecipe(int characterId) async {
    final list = savedRecipes;
    list.add(characterId.toString());
    await _preferences.setStringList(_savedRecipeIdListKey, list);
    notifyListeners();
  }

  Future<void> removeSavedRecipe(int characterId) async {
    final list = savedRecipes;
    list.remove(characterId.toString());
    await _preferences.setStringList(_savedRecipeIdListKey, list);
    notifyListeners();
  }

  List<String> get likedRecipes =>
      _preferences.getStringList(_likedRecipeIdListKey) ?? [];

  Future<void> likeRecipe(int recipeId) async {
    final list = likedRecipes;
    list.add(recipeId.toString());
    await _preferences.setStringList(_likedRecipeIdListKey, list);
    notifyListeners();
  }

  Future<void> removeLikedRecipe(int recipeId) async {
    final list = savedRecipes;
    list.remove(likedRecipes.toString());
    await _preferences.setStringList(_likedHowToIdList, list);
    notifyListeners();
  }

  // Nasıl yapılırları kaydetme ve beğenme

  List<String> get savedHowTos =>
      _preferences.getStringList(_savedHowToIdList) ?? [];

  Future<void> saveHowTo(int howToId) async {
    final list = savedHowTos;
    list.add(howToId.toString());
    await _preferences.setStringList(_savedHowToIdList, list);
    notifyListeners();
  }

  Future<void> removeSavedHowTo(int howToId) async {
    final list = savedHowTos;
    list.remove(howToId.toString());
    await _preferences.setStringList(_savedHowToIdList, list);
    notifyListeners();
  }

  List<String> get likedHowTos =>
      _preferences.getStringList(_likedHowToIdList) ?? [];

  Future<void> likeHowTo(int howToId) async {
    final list = likedHowTos;
    list.add(howToId.toString());
    await _preferences.setStringList(_likedHowToIdList, list);
    notifyListeners();
  }

  Future<void> removeLikedHowTo(int howToId) async {
    final list = likedHowTos;
    list.remove(howToId.toString());
    await _preferences.setStringList(_likedHowToIdList, list);
    notifyListeners();
  }

  // Örgü kafeleri kaydetme ve beğenme

  List<String> get savedKnittingCafes =>
      _preferences.getStringList(_savedKnittingCafeIdList) ?? [];

  Future<void> saveKnittingCafe(int cafeId) async {
    final list = savedKnittingCafes;
    list.add(cafeId.toString());
    await _preferences.setStringList(_savedKnittingCafeIdList, list);
    notifyListeners();
  }

  Future<void> removeSavedKnittingCafe(int cafeId) async {
    final list = savedKnittingCafes;
    list.remove(cafeId.toString());
    await _preferences.setStringList(_savedKnittingCafeIdList, list);
    notifyListeners();
  }

  List<String> get likedKnittingCafes =>
      _preferences.getStringList(_likedKnittingCafeIdList) ?? [];

  Future<void> likeKnittingCafe(int cafeId) async {
    final list = likedKnittingCafes;
    list.add(cafeId.toString());
    await _preferences.setStringList(_likedKnittingCafeIdList, list);
    notifyListeners();
  }

  Future<void> removeLikedKnittingCafe(int cafeId) async {
    final list = likedKnittingCafes;
    list.remove(cafeId.toString());
    await _preferences.setStringList(_likedKnittingCafeIdList, list);
    notifyListeners();
  }

  // *****************************************************************************

  // GENEL AYARLAR

  // Koyu-Açık temalar arasında geçiş yapmak, mevcut temayı korumak
  Future<void> toggleTheme() async {
    await _preferences.setBool(_darkThemeKey, !darkTheme);
    notifyListeners();
  }

  // Güncelleme olduğunu haber vermek
  Future<void> setFirstOpeningAfterUpdate() async {
    await _preferences.setBool(_firstOpenAfterUpdateKey, false);
    notifyListeners();
  }

  // Profil fotoğrafını ayarlamak
  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null) return;

    await _preferences.setString(_profilePhotoFilePathKey, image.path);
    notifyListeners();
  }
}
