import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_impl.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
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

    test(' should be return idx when insertNote success', () async {
      when(mockNoteRemoteDataSource.insertNote(any)).thenAnswer((_) async => 1);

      final int idx = await noteRepository.insertNote(testNote);
      verify(mockNoteRemoteDataSource.insertNote(testNote));
      expect(idx, 1);
    });

    test('should be throw NoteRepositoryFailure when insertNote fail ', () {
      when(mockNoteRemoteDataSource.insertNote(any)).thenAnswer((_) async => 0);

      expect(noteRepository.insertNote(testNote), throwsA(NoteRepositoryFailure()));
      verify(mockNoteRemoteDataSource.insertNote(testNote));
    });

    test('should return all NoteList when getNotes called', () async {
      when(mockNoteRemoteDataSource.getNotes()).thenAnswer((_) async => []);
      final List<Note> expectEmptyNotes = await noteRepository.getNotes();
      verify(mockNoteRemoteDataSource.getNotes());
      expect(expectEmptyNotes.isEmpty, true);

      when(mockNoteRemoteDataSource.getNotes()).thenAnswer((_) async => [testNote, testNote]);
      final List<Note> notes = await noteRepository.getNotes();
      verify(mockNoteRemoteDataSource.getNotes());
      expect(notes.length, 2);
    });

    test('should be throw NoteRepositoryFailure when there is no idx', () async {
      when(mockNoteRemoteDataSource.getNoteByIdx(2)).thenAnswer((_) async => null);
      expect(noteRepository.getNoteByIdx(2), throwsA(NoteRepositoryFailure()));
    });

    test('getNoteByIdx test when success', () async {
      when(mockNoteRemoteDataSource.getNoteByIdx(1)).thenAnswer((_) async => testNote.copyWith(idx: 1));

      final Note targetNote = await noteRepository.getNoteByIdx(1);
      verify(mockNoteRemoteDataSource.getNoteByIdx(1));
      expect(targetNote.idx, 1);
    });

    test('updateNote test when success', () async {
      when(mockNoteRemoteDataSource.updateNote(any)).thenAnswer((_) async => 1);

      await noteRepository.updateNote(testNote.copyWith(idx: 1));
      verify(mockNoteRemoteDataSource.updateNote(any));
    });

    test('should be throw NoteRepositoryFailure when updateNote fail', () async {
      when(mockNoteRemoteDataSource.updateNote(any)).thenAnswer((_) async => 0);

      expect(noteRepository.updateNote(testNote.copyWith(idx: 1)), throwsA(NoteRepositoryFailure()));
      verify(mockNoteRemoteDataSource.updateNote(any));
    });

    test('should be throw NoteRepositoryFailure when deleteNote fail', () async {
      when(mockNoteRemoteDataSource.deleteNote(any)).thenAnswer((_) async => 0);

      expect(noteRepository.deleteNote(1), throwsA(NoteRepositoryFailure()));
      verify(mockNoteRemoteDataSource.deleteNote(1));
    });

    test('deleteNote test', () async {
      when(mockNoteRemoteDataSource.deleteNote(any)).thenAnswer((_) async => 1);

      await noteRepository.deleteNote(1);
      verify(mockNoteRemoteDataSource.deleteNote(1));
    });
  });
}
