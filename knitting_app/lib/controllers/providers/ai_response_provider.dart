import 'package:flutter/material.dart';
import 'package:knitting_app/models/ai_response_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AiAnswersProvider extends ChangeNotifier {
  Database? _db;
  bool _isLoading = false;
  bool _isInitialized = false;
  List<AiResponseModel> _aiAnswers = [];

  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  List<AiResponseModel> get aiAnswers => _aiAnswers;

  Future<void> init() async {
    if (_isInitialized) return;

    _isLoading = true;
    notifyListeners();

    _db = await openDatabase(
      join(await getDatabasesPath(), 'aiAnswers.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE aiAnswers(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          question TEXT,
          answer TEXT,
          imagePath TEXT,
          time INTEGER
          )
        ''');
      },
    );

    _isInitialized = true;
    _isLoading = false;

    await loadAiAnswers();
  }

  Future<void> loadAiAnswers() async {
    if (_db == null) return;

    final data = await _db!.query('aiAnswers', orderBy: 'id DESC');
    _aiAnswers = data.map((e) => AiResponseModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addAiAnswer(
    String question,
    String answer,
    String imagePath,
  ) async {
    if (_db == null) return;

    await _db!.insert('aiAnswers', {
      'question': question,
      'answer': answer,
      'imagePath': imagePath,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
    await loadAiAnswers();
  }

  Future<void> deleteAiAnswer(int id) async {
    if (_db == null) return;

    await _db!.delete('aiAnswers', where: 'id = ?', whereArgs: [id]);
    await loadAiAnswers();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'aiAnswers.db');

    await deleteDatabase(path);
    _db = null;
    _isInitialized = false;
    _aiAnswers = [];

    notifyListeners();
  }
}
