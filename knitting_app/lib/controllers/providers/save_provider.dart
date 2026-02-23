import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:knitting_app/models/design_model.dart';
import 'package:knitting_app/models/pattern_model.dart';
import 'package:knitting_app/models/tutorial_model.dart';

class SaveProvider extends ChangeNotifier {
  List<PatternModel> _savedPatterns = [];

  List<PatternModel> get savedPatterns => _savedPatterns;

  Box<PatternModel> get _patternBox =>
      Hive.box<PatternModel>('savedPatternsBox');

  bool isPatternSaved(String id) => _patternBox.containsKey(id);

  void togglePatternSave(PatternModel pattern) {
    final key = pattern.id.toString();
    if (_patternBox.containsKey(key)) {
      _patternBox.delete(key);
    } else {
      _patternBox.put(key, pattern);
    }
    _savedPatterns = _patternBox.values.toList();
    notifyListeners();
  }

  void loadSaveds() async {
    // Fiziksel olarak diskten siliyoruz
    _savedPatterns = _patternBox.values.toList();
    notifyListeners();
  }
}
