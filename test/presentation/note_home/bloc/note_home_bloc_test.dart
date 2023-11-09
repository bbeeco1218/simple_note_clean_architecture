import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/delete_note_use_case.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart';
import 'package:simple_note_clean_architecture/presentation/note_home/bloc/note_home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'note_home_bloc_test.mocks.dart';

@GenerateMocks([GetNotesUseCase, DeleteNoteUseCase])
void main() {
  late MockGetNotesUseCase mockGetNotes;
  late MockDeleteNoteUseCase mockDeleteNote;
  late NoteHomeBloc noteHomebloc;

  setUp(() {
    mockGetNotes = MockGetNotesUseCase();
    mockDeleteNote = MockDeleteNoteUseCase();
    noteHomebloc = NoteHomeBloc(getNotes: mockGetNotes, deleteNote: mockDeleteNote);
  });

  group('note home bloc test', () {
    final List<Note> testNotes = [const Note(title: 'test', desc: 'desc', color: 1, idx: 1)];
    void setGetNotes() => when(mockGetNotes.call(NoParams())).thenAnswer((_) async => testNotes);

    blocTest<NoteHomeBloc, NoteHomeState>(
      'NoteHomeStarted 일때 저장된 노트를 불러와야한다.',
      setUp: setGetNotes,
      build: () => noteHomebloc,
      act: (bloc) => bloc.add(NoteHomeStarted()),
      expect: () => <NoteHomeState>[
        NoteHomeState(notes: testNotes),
      ],
    );

    blocTest<NoteHomeBloc, NoteHomeState>(
      'NoteHomeDeleted 일때 저장된 노트를 삭제해야한다.',
      setUp: () => when(mockDeleteNote.call(any)).thenAnswer((_) async {}),
      build: () => noteHomebloc,
      act: (bloc) => bloc.add(NoteHomeNoteDeleted(noteIdx: 1)),
      expect: () => const <NoteHomeState>[
        NoteHomeState(notes: []),
      ],
    );

    blocTest<NoteHomeBloc, NoteHomeState>(
      'NoteHomeDeleted 일때 노트가 없다면 toastMessage를 emit',
      setUp: () => when(mockDeleteNote.call(any)).thenThrow(NoteRepositoryFailure()),
      build: () => noteHomebloc,
      act: (bloc) => bloc.add(NoteHomeNoteDeleted(noteIdx: 1)),
      expect: () => <NoteHomeState>[
        const NoteHomeState(toastMessage: deleteNoteFailMessage),
      ],
    );
  });
}
