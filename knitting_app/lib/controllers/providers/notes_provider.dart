import 'package:flutter/material.dart';
import 'package:knitting_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesProvider extends ChangeNotifier {
  Database? _db;
  bool _isLoading = false;
  bool _initialized = false;
  List<Note> _notes = [];

  bool get isLoading => _isLoading;
  bool get isInitialized => _initialized;
  List<Note> get notes => _notes;

  /// 1️⃣ Database init
  Future<void> init() async {
    if (_initialized) return;

    _isLoading = true;
    notifyListeners();

    _db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            note TEXT,
            time INTEGER
          )
          ''');
      },
    );

    _initialized = true;
    _isLoading = false;

    await loadNotes();
  }

  /// 2️⃣ READ
  Future<void> loadNotes() async {
    if (_db == null) return;

    final data = await _db!.query('notes', orderBy: 'id DESC');
    _notes = data.map((e) => Note.fromMap(e)).toList();
    notifyListeners();
  }

  /// 3️⃣ CREATE
  Future<void> addNote(String title, String note) async {
    if (_db == null) return;

    await _db!.insert('notes', {
      'title': title,
      'note': note,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
    await loadNotes();
  }

  Future<void> updateNote(String title, String note, int id) async {
    if (_db == null) return;

    await _db!.update('notes', {
      'title': title,
      'note': note,
      'time': DateTime.now().millisecondsSinceEpoch,
    },
    where: 'id = ?',
    whereArgs: [id],
    );

    await loadNotes();
  }

  /// 4️⃣ DELETE
  Future<void> deleteNote(int id) async {
    if (_db == null) return;

    await _db!.delete('notes', where: 'id = ?', whereArgs: [id]);
    await loadNotes();
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    await deleteDatabase(path);
    _db = null;
    _initialized = false;
    _notes = [];

    notifyListeners();
  }
}
