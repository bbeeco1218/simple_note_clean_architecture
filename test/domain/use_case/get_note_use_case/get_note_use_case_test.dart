import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_note_use_case.dart';

import 'get_note_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  group('get note use case test', () {
    late final GetNoteUseCase useCase;
    late final MockNoteRepository mockNoteRepository;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1, idx: 1);

    setUpAll(() {
      mockNoteRepository = MockNoteRepository();
      useCase = GetNoteUseCase(noteRepository: mockNoteRepository);
    });

    test('노트가 존재하지 않다면 NoteRepositoryFailure를 Throw', () async {
      when(mockNoteRepository.getNoteByIdx(any)).thenThrow(NoteRepositoryFailure());
      expect(useCase.call(const GetNoteParams(noteIdx: 2)), throwsA(NoteRepositoryFailure()));
    });

    test('노트가 존재한다면 Note를 리턴', () async {
      when(mockNoteRepository.getNoteByIdx(any)).thenAnswer((_) async => testNote);
      expect(await useCase.call(const GetNoteParams(noteIdx: 1)), testNote);
    });
  });
}
