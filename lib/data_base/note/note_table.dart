import 'package:simple_note_clean_architecture/core/sqf_table.dart';
import 'package:sqflite/sqflite.dart';

class NoteTable implements SqfliteTable {
  @override
  final String databasePath = "notes_db";

  @override
  final int version = 1;

  @override
  Future<Database> get database async {
    return await openDatabase(
      databasePath,
      version: version,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');
      },
    );
  }
}
