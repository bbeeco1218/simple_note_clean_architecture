import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    await db.execute(
        'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');

    final noteRemoteDataSource = NoteRemoteDataSource(db: db);

    await noteRemoteDataSource.insertNote(Note(
      title: 'test',
      desc: 'test',
      color: 1,
      createAt: DateTime.now().toLocal(),
    ));

    expect((await noteRemoteDataSource.getNotes()).length, 1);

    Note note = (await noteRemoteDataSource.getNoteByIdx(1))!;
    expect(note.idx, 1);

    await noteRemoteDataSource.updateNote(note.copyWith(title: 'change'));

    note = (await noteRemoteDataSource.getNoteByIdx(1))!;
    expect(note.title, 'change');

    await noteRemoteDataSource.deleteNote(note);
    expect((await noteRemoteDataSource.getNotes()).length, 0);

    await db.close();
  });
}

class NoteRemoteDataSource {
  final Database db;

  NoteRemoteDataSource({required this.db});

  Future<Note?> getNoteByIdx(int idx) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'idx = ?',
      whereArgs: [idx],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'idx = ?',
      whereArgs: [note.idx],
    );
  }

  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'idx = ?',
      whereArgs: [note.idx],
    );
  }
}
