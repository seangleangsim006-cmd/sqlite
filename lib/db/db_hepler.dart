import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHepler {
  // create database
  static Future<Database> openDB() async {
    final path = join(await getDatabasesPath(), 'note_app.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, position TEXT, skill TEXT, category TEXT,date TEXT)",
        );
      },
    );
  }

  // Insert
  static Future<int> insertNote(
    String Position,
    String Skill,
    String Category,
    String Date,
  ) async {
    final db = await openDB();
    return db.insert('note', {
      'position': Position,
      'skill': Skill,
      'category': Category,
      'date': Date,
    });
  }

  // Get data from database
  static Future<List<Map<String, dynamic>>> getNote() async {
    final db = await openDB();
    return db.query('note');
  }

  //delete
  static Future<int> deleteNote(int id) async {
    final db = await openDB();
    return db.delete('note', where: "id = ?", whereArgs: [id]);
  }

  // update
  static Future<int> updateNote(
    int id,
    String newPosition,
    String newSkill,
    String newCategory,
    String newDate,
  ) async {
    final db = await openDB();
    return db.update(
      'note',
      {
        'position': newPosition,
        'skill': newSkill,
        'category': newCategory,
        'date': newDate,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
