import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knitting_app/models/design_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/tutorial_model.dart';

class LikeProvider extends ChangeNotifier {
  List<PatternModel> _likedPatterns = [];

  bool _isLoading = false;

  List<PatternModel> get likedPatterns => _likedPatterns;

  bool get isLoading => _isLoading;

  // Hive Box referansları
  Box<PatternModel> get _likedPatternsBox =>
      Hive.box<PatternModel>('likedPatternsBox');
  

  // Bu şekilde arama daha hızlı
  bool isPatternLiked(String id) => _likedPatternsBox.containsKey(id);

  void togglePatternLike(PatternModel pattern) {
    final String key = pattern.id
        .toString(); // böyle yaparak daha da hızlandırdık

    if (_likedPatternsBox.containsKey(key)) {
      _likedPatternsBox.delete(key);
    } else {
      _likedPatternsBox.put(key, pattern);
    }

    // İşlemlerden sonra güncelleme yap UI için
    _likedPatterns = _likedPatternsBox.values.toList();

    notifyListeners();
  }

  Future<void> loadLikeds() async {
    _isLoading = true;
    notifyListeners();
    
    _likedPatterns = _likedPatternsBox.values.toList();

    _isLoading = false;
    notifyListeners();
  }
}
