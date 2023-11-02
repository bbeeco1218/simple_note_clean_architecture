// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_impl.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('note repositoryimpl test', () {
    late Database mockDb;
    late NoteRemoteDataSource noteRemoteDataSource;
    late NoteRepositoryImpl noteRepository;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1);

    setUp(() async {
      mockDb = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await mockDb.execute(
          'CREATE TABLE note (idx INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, color INTEGER, createAt TEXT, updateAt TEXT)');

      noteRemoteDataSource = NoteRemoteDataSource(db: mockDb);
      noteRepository = NoteRepositoryImpl(remoteDataSource: noteRemoteDataSource);
    });

    tearDown(() async {
      await mockDb.close();
    });
    test('insertNote test', () async {
      final int idx = await noteRepository.insertNote(testNote);
      expect(idx, isNot(0));
    });
    test('getNotes test', () async {
      final List<Note> expectEmptyNotes = await noteRepository.getNotes();
      expect(expectEmptyNotes.isEmpty, true);

      await noteRepository.insertNote(testNote);
      await noteRepository.insertNote(testNote);

      final List<Note> notes = await noteRepository.getNotes();
      expect(notes.length, 2);
    });
    test('getNoteByIdx test', () async {
      final int idx = await noteRepository.insertNote(testNote);
      final Note? targetNote = await noteRepository.getNoteByIdx(idx: idx);
      expect(targetNote?.idx, idx);

      final Note? targetNote2 = await noteRepository.getNoteByIdx(idx: 2);
      expect(targetNote2?.idx, isNull);
    });

    test('updateNote test', () async {
      final int idx = await noteRepository.insertNote(testNote);
      final Note? targetNote = await noteRepository.getNoteByIdx(idx: idx);

      final bool isSuccessUpdateNote = await noteRepository.updateNote(targetNote!.copyWith(title: 'change'));
      expect(isSuccessUpdateNote, true);
    });

    test('deleteNote test', () async {
      final int targetIdx = await noteRemoteDataSource.insertNote(testNote);

      final isSuccessDelete = await noteRepository.deleteNote(targetIdx);
      expect(isSuccessDelete, true);
    });

    // final NoteRepositoryImpl noteRepository = NoteRepositoryImpl();
    // test('get notes', () {
    //   final List<Note> noteList = [
    //     Note.empty(),
    //     Note.empty(),
    //   ];

    //   expect(noteRepository.getNotes(), noteList);
    // });

    // test('get note by id', () {
    //   expect(noteRepository.getNoteById(idx: 0), const Note(title: '', desc: '', color: 0, idx: 0));
    // });

    // test('insert note', () {
    //   expect(noteRepository.insertNote(Note.empty().copyWith(title: '1', desc: '1')), true);
    // });

    // test('validate insert', () {
    //   expect(noteRepository.validateInsert(Note.empty()), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1')), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(desc: '1')), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1', desc: '1')), true);
    // });

    // test('validate title', () {
    //   expect(noteRepository.validateTitle(''), false);
    //   expect(noteRepository.validateTitle('1'), true);
    // });

    // test('validate desc', () {
    //   expect(noteRepository.validateDesc(''), false);
    //   expect(noteRepository.validateDesc('1'), true);
    // });

    // test('validate idx', () {
    //   expect(noteRepository.validateIdx(-1), false);
    //   expect(noteRepository.validateIdx(1), true);
    // });

    // test('update note', () {
    //   // expect(noteRepository.updateNote(Note.empty()), false);
    //   // expect(noteRepository.updateNote(Note.empty().copyWith(title: '', desc: '', idx: 1)), false);
    //   expect(noteRepository.updateNote(Note.empty().copyWith(title: '1', desc: '1', idx: 1)), true);
    // });

    // test('delete note', () {
    //   // expect(noteRepository.deleteNote(-1), false);
    //   expect(noteRepository.deleteNote(1), true);
    // });
  });
}