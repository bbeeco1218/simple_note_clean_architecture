import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart';
import 'package:simple_note_clean_architecture/presentation/note_home/bloc/note_home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'note_home_bloc_test.mocks.dart';

@GenerateMocks([GetNotesUseCase])
void main() {
  late final MockGetNotesUseCase mockGetNotes;
  setUpAll(() {
    mockGetNotes = MockGetNotesUseCase();
  });

  group('note home bloc test', () {
    final List<Note> testNotes = [const Note(title: 'test', desc: 'desc', color: 1, idx: 1)];
    when(mockGetNotes.call(NoParams())).thenAnswer((_) async => testNotes);
    blocTest<NoteHomeBloc, NoteHomeState>(
      'emits [NoteHomeState] when NoteHomeStarted is added.',
      build: () => NoteHomeBloc(mockGetNotes),
      act: (bloc) => bloc.add(NoteHomeStarted()),
      expect: () => <NoteHomeState>[NoteHomeState(notes: testNotes)],
    );
  });
}
