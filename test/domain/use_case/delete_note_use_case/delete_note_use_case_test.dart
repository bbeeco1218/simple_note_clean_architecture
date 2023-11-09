import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';
import 'package:simple_note_clean_architecture/domain/use_case/delete_note_use_case.dart';

import 'delete_note_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  group('delete note use case test', () {
    late final DeleteNoteUseCase useCase;
    late final MockNoteRepository mockNoteRepository;

    setUpAll(() {
      mockNoteRepository = MockNoteRepository();
      useCase = DeleteNoteUseCase(noteRepository: mockNoteRepository);
    });

    test('해당 노트가 없거나 실패했다면 NoteRepositoryFailuer를 throw ', () async {
      when(mockNoteRepository.deleteNote(any)).thenThrow(NoteRepositoryFailure());
      expect(useCase.call(const DeleteNoteParams(noteIdx: 2)), throwsA(NoteRepositoryFailure()));
    });

    test('노트가 문제없이 삭제되어야한다.', () async {
      when(mockNoteRepository.deleteNote(any)).thenAnswer((_) async {});
      await useCase.call(const DeleteNoteParams(noteIdx: 1));
      verify(mockNoteRepository.deleteNote(1));
    });
  });
}
