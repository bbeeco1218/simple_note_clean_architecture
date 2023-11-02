import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('note remote data source test', () {
    late Database mockDb;
    late NoteRemoteDataSource noteRemoteDataSource;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1);

    setUp(() async {
      mockDb = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await mockDb.execute(
          'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');

      noteRemoteDataSource = NoteRemoteDataSource(db: mockDb);
    });

    tearDown(() async {
      await mockDb.close();
    });
    test('insertNote test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote);
      expect(idx, isNot(0));
    });

    test('getNotes test', () async {
      final List<Note> expectEmptyNotes = await noteRemoteDataSource.getNotes();
      expect(expectEmptyNotes.isEmpty, true);

      await noteRemoteDataSource.insertNote(testNote);
      await noteRemoteDataSource.insertNote(testNote);

      final List<Note> notes = await noteRemoteDataSource.getNotes();
      expect(notes.length, 2);
    });

    test('getNoteByIdx test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote);
      final Note? targetNote = await noteRemoteDataSource.getNoteByIdx(idx);
      expect(targetNote?.idx, idx);

      final Note? targetNote2 = await noteRemoteDataSource.getNoteByIdx(2);
      expect(targetNote2?.idx, isNull);
    });

    test('updateNote test', () async {
      final int idx = await noteRemoteDataSource.insertNote(testNote);
      final Note? targetNote = await noteRemoteDataSource.getNoteByIdx(idx);

      await noteRemoteDataSource.updateNote(targetNote!.copyWith(title: 'change'));
      final Note? updatedNote = await noteRemoteDataSource.getNoteByIdx(idx);

      expect(updatedNote?.title, 'change');
    });

    test('deleteNote test', () async {
      final int targetIdx = await noteRemoteDataSource.insertNote(testNote);
      await noteRemoteDataSource.deleteNote(targetIdx);

      final Note? deletedNote = await noteRemoteDataSource.getNoteByIdx(targetIdx);

      expect(deletedNote, isNull);
    });
  });
}
