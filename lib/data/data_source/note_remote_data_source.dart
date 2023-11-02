import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<int> insertNote(Note note) async {
    final DateTime now = DateTime.now().toLocal();
    return await db.insert('note', note.copyWith(createAt: now, updateAt: now).toJson());
  }

  Future<int> updateNote(Note note) async {
    final DateTime now = DateTime.now().toLocal();
    return await db.update(
      'note',
      note.copyWith(updateAt: now).toJson(),
      where: 'idx = ?',
      whereArgs: [note.idx],
    );
  }

  /// Returns the number of rows affected.
  Future<int> deleteNote(int idx) async {
    return await db.delete(
      'note',
      where: 'idx = ?',
      whereArgs: [idx],
    );
  }
}
