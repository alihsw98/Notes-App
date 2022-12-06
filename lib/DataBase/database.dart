import 'dart:async';
import 'package:notes_app/DataBase/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {

  initialDataBase() async{
    Future<Database>? database = openDatabase(
      join(await getDatabasesPath(),'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
        );
      },
      version: 1
    );
    return database;
  }

  Future<void> insertNote(Note note) async {
    Database db = await initialDataBase();
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> notes() async {
    Database db = await initialDataBase();
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      );
    });
  }
}