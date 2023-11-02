import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database mockDb;
  late NoteRemoteDataSource noteRemoteDataSource;

  const Note testNote = Note(title: 'test', desc: 'test', color: 1);

  setUp(() async {
    mockDb = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await mockDb.execute(
        'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');

    noteRemoteDataSource = NoteRemoteDataSource(db: mockDb);
  });

  group('note remote data source test', () {
    test('insertNote test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote.copyWith(createAt: DateTime.now()));
      expect(idx, isNot(0));

      await mockDb.close();
    });

    test('getNoteByIdx test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote.copyWith(createAt: DateTime.now()));
      final Note? targetNote = await noteRemoteDataSource.getNoteByIdx(idx);
      expect(targetNote?.idx, idx);

      final Note? targetNote2 = await noteRemoteDataSource.getNoteByIdx(2);
      expect(targetNote2?.idx, isNull);
      await mockDb.close();
    });

    test('updateNote test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote.copyWith(createAt: DateTime.now()));
      final Note? targetNote = await noteRemoteDataSource.getNoteByIdx(idx);

      final Note expectNote = targetNote!.copyWith(title: 'change');
      await noteRemoteDataSource.updateNote(expectNote);
      final Note? updatedNote = await noteRemoteDataSource.getNoteByIdx(idx);

      expect(updatedNote, expectNote);

      await mockDb.close();
    });

    test('deleteNote test', () async {
      final int targetIdx = await noteRemoteDataSource.insertNote(testNote.copyWith(createAt: DateTime.now()));
      await noteRemoteDataSource.deleteNote(targetIdx);

      final Note? deletedNote = await noteRemoteDataSource.getNoteByIdx(targetIdx);

      expect(deletedNote, isNull);
      await mockDb.close();
    });
  });
}
