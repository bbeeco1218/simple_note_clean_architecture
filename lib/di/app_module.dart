import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class AppModule {
  @preResolve
  Future<Database> get db => openDatabase(
        'notes_db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');
        },
      );
}
