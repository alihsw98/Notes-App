import 'dart:async';
import 'package:Notes/DataBase/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  initialDataBase() async {
    Future<Database>? database = openDatabase(
        join(await getDatabasesPath(), 'notes.db'), onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, body TEXT, color TEXT)',
      );
    }, version: 1);
    return database;
  }

  Future<void> addNote(String title, String body, [String color = '91F48F']) async {
    Database db = await initialDataBase();
    db.rawInsert('INSERT INTO notes(title, body, color) VALUES(?, ?, ?)', [title, body , color]);
  }

  Future<List<Note>> notes() async {
    Database db = await initialDataBase();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          color: maps[i]['color']);
    });
  }

  Future<void> deleteNote(Note note) async {
    Database db = await initialDataBase();
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  getNoteByTitle(String title) async {
    Database db = await initialDataBase();
    // raw query
    List<Map> maps =
        await db.rawQuery('SELECT * FROM notes WHERE title=?', [title]);

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          color: maps[i]['color']);
    });
  }

  getNoteById(int id) async {
    Database db = await initialDataBase();
    // raw query
    List<Map> maps = await db.rawQuery('SELECT * FROM notes WHERE id=?', [id]);

    return List.generate(maps.length, (i) {
      return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
          color: maps[i]['color']);
    });
  }

  updateNote(int id, String title, String body) async {
    Database db = await initialDataBase();

    // row to update
    Map<String, dynamic> row = {'title': title, 'body': body};

    await db.update('notes', row, where: 'id = ?', whereArgs: [id]);
  }
}
