import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_impl.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'note_repository_impl_test.mocks.dart';

@GenerateMocks([NoteRemoteDataSource])
void main() {
  group('note repositoryimpl test', () {
    late MockNoteRemoteDataSource mockNoteRemoteDataSource;
    late NoteRepositoryImpl noteRepository;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1);

    setUp(() async {
      mockNoteRemoteDataSource = MockNoteRemoteDataSource();
      noteRepository = NoteRepositoryImpl(remoteDataSource: mockNoteRemoteDataSource);
    });

    test('insertNote test', () async {
      when(mockNoteRemoteDataSource.insertNote(testNote)).thenAnswer((_) async => 1);

      final int idx = await noteRepository.insertNote(testNote);
      verify(mockNoteRemoteDataSource.insertNote(testNote));
      expect(idx, 1);
    });

    test('getNotes test', () async {
      when(mockNoteRemoteDataSource.getNotes()).thenAnswer((_) async => []);
      final List<Note> expectEmptyNotes = await noteRepository.getNotes();
      verify(mockNoteRemoteDataSource.getNotes());
      expect(expectEmptyNotes.isEmpty, true);

      when(mockNoteRemoteDataSource.getNotes()).thenAnswer((_) async => [testNote, testNote]);
      final List<Note> notes = await noteRepository.getNotes();
      verify(mockNoteRemoteDataSource.getNotes());
      expect(notes.length, 2);
    });

    test('getNoteByIdx test', () async {
      when(mockNoteRemoteDataSource.getNoteByIdx(1)).thenAnswer((_) async => testNote.copyWith(idx: 1));

      final Note? targetNote = await noteRepository.getNoteByIdx(idx: 1);
      verify(mockNoteRemoteDataSource.getNoteByIdx(1));
      expect(targetNote?.idx, 1);

      when(mockNoteRemoteDataSource.getNoteByIdx(2)).thenAnswer((_) async => null);
      final Note? targetNote2 = await noteRepository.getNoteByIdx(idx: 2);
      expect(targetNote2?.idx, isNull);
    });

    test('updateNote test', () async {
      when(mockNoteRemoteDataSource.updateNote(any)).thenAnswer((_) async => 1);

      final bool isSuccessUpdateNote = await noteRepository.updateNote(testNote.copyWith(idx: 1));
      expect(isSuccessUpdateNote, true);
    });

    test('deleteNote test', () async {
      when(mockNoteRemoteDataSource.deleteNote(any)).thenAnswer((_) async => 1);

      final isSuccessDelete = await noteRepository.deleteNote(1);
      expect(isSuccessDelete, true);
    });
  });
}
