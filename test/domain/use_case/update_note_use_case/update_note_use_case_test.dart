import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';
import 'package:simple_note_clean_architecture/domain/use_case/update_note_use_case.dart';

import 'update_note_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  group('update note use case test', () {
    late final UpdateNoteUseCase useCase;
    late final MockNoteRepository mockNoteRepository;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1);

    setUpAll(() {
      mockNoteRepository = MockNoteRepository();
      useCase = UpdateNoteUseCase(noteRepository: mockNoteRepository);
    });

    test('노트 업데이트가 실패', () {
      when(mockNoteRepository.updateNote(any)).thenThrow(NoteRepositoryFailure());
      expect(useCase.call(const UpdateNoteParams(note: testNote)), throwsA(NoteRepositoryFailure()));
    });

    test('노트 업데이트 성공', () async {
      when(mockNoteRepository.updateNote(any)).thenAnswer((_) async {});
      await useCase.call(const UpdateNoteParams(note: testNote));
      verify(mockNoteRepository.updateNote(any));
    });
  });
}
