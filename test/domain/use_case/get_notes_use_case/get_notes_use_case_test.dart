import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart';
import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  group('get notes use case test', () {
    late final GetNotesUseCase useCase;
    late final MockNoteRepository mockNoteRepository;

    const Note testNote = Note(title: 'test', desc: 'test', color: 1);

    setUpAll(() {
      mockNoteRepository = MockNoteRepository();
      useCase = GetNotesUseCase(noteRepository: mockNoteRepository);
    });

    test('노트리스트를 조회한다.', () async {
      when(mockNoteRepository.getNotes()).thenAnswer((_) async => []);
      final List<Note> resultNotes = await useCase.call(NoParams());
      expect(resultNotes, isEmpty);

      when(mockNoteRepository.getNotes()).thenAnswer((_) async => [testNote.copyWith(idx: 1), testNote.copyWith(idx: 2)]);
      final List<Note> resultNotes2 = await useCase.call(NoParams());
      expect(resultNotes2.length, 2);
    });
  });
}
