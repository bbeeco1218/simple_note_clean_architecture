import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_note_clean_architecture/core/theme/app_colors.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/update_note_use_case.dart';
import 'package:simple_note_clean_architecture/presentation/note_detail/bloc/note_detail_bloc.dart';

import 'note_detail_bloc_test.mocks.dart';

@GenerateMocks([UpdateNoteUseCase])
void main() {
  late NoteDetailBloc noteHomeBloc;
  late MockUpdateNoteUseCase mockUpdateNote;

  setUp(() {
    mockUpdateNote = MockUpdateNoteUseCase();
    noteHomeBloc = NoteDetailBloc(updateNote: mockUpdateNote);
  });

  tearDown(() => noteHomeBloc.close());

  group('note detail bloc test', () {
    final Note testNote = Note(
      title: 'test',
      desc: 'desc',
      color: AppColors.darkGray.value,
      idx: 1,
      createAt: DateTime.now(),
    );

    final Note emptyDescNote = Note.empty().copyWith(title: 'test');

    final Note saveNewNote = Note.empty().copyWith(title: 'test', desc: 'test');
    final Note saveUpdateNote = saveNewNote.copyWith(idx: 1);

    test('validate title and desc', () {
      final bool isValidatedTitleFalse = noteHomeBloc.validateTitle(Note.empty());
      expect(isValidatedTitleFalse, isFalse);

      final bool isValidatedTitleTrue = noteHomeBloc.validateTitle(Note.empty().copyWith(title: 'ab'));
      expect(isValidatedTitleTrue, isTrue);

      final bool isValidatedDescFalse = noteHomeBloc.validateDesc(Note.empty());
      expect(isValidatedDescFalse, isFalse);

      final bool isValidatedDescTrue = noteHomeBloc.validateDesc(Note.empty().copyWith(desc: 'ab'));
      expect(isValidatedDescTrue, isTrue);
    });

    blocTest<NoteDetailBloc, NoteDetailState>(
      'NoteDetail이 처음 시작할때 event에서 받아온 Note를 emit해줘야 한다.',
      build: () => noteHomeBloc,
      act: (bloc) => bloc.add(NoteDetailStarted(note: testNote)),
      expect: () => <NoteDetailState>[
        NoteDetailState(
          note: testNote,
          saveButtonStatus: SaveButtonStatus.idle,
          toastMessage: '',
        ),
      ],
    );

    blocTest<NoteDetailBloc, NoteDetailState>(
      'NoteDetailColorChanged event가 들어오면 컬러를 바꿔줘야한다.',
      seed: () => NoteDetailState(note: testNote, saveButtonStatus: SaveButtonStatus.idle, toastMessage: ''),
      build: () => noteHomeBloc,
      act: (bloc) => bloc.add(NoteDetailColorChanged(color: AppColors.illusion)),
      expect: () => <NoteDetailState>[
        NoteDetailState(
          note: testNote.copyWith(color: AppColors.illusion.value),
          saveButtonStatus: SaveButtonStatus.idle,
          toastMessage: '',
        ),
      ],
    );

    blocTest<NoteDetailBloc, NoteDetailState>(
      '제목이 없는상태에서 save를 하면 토스트메세지',
      seed: () => NoteDetailState(note: Note.empty(), saveButtonStatus: SaveButtonStatus.idle, toastMessage: ''),
      build: () => noteHomeBloc,
      act: (bloc) => bloc.add(NoteDetailSaved()),
      expect: () => <NoteDetailState>[
        NoteDetailState(
          note: Note.empty(),
          saveButtonStatus: SaveButtonStatus.loading,
          toastMessage: '',
        ),
        NoteDetailState(
          note: Note.empty(),
          saveButtonStatus: SaveButtonStatus.idle,
          toastMessage: emptyTitleMessage,
        ),
      ],
    );

    blocTest<NoteDetailBloc, NoteDetailState>(
      '내용이 없는상태에서 save를 하면 토스트메세지',
      seed: () => NoteDetailState(note: emptyDescNote, saveButtonStatus: SaveButtonStatus.idle, toastMessage: ''),
      build: () => noteHomeBloc,
      act: (bloc) => bloc.add(NoteDetailSaved()),
      expect: () => <NoteDetailState>[
        NoteDetailState(
          note: emptyDescNote,
          saveButtonStatus: SaveButtonStatus.loading,
          toastMessage: '',
        ),
        NoteDetailState(
          note: emptyDescNote,
          saveButtonStatus: SaveButtonStatus.idle,
          toastMessage: emptyDescMessage,
        ),
      ],
    );

    blocTest<NoteDetailBloc, NoteDetailState>(
      'idx가 null이 아닌 노트를 저장하면 updateNote를 해야한다.',
      setUp: () => when(mockUpdateNote.call(any)).thenAnswer((_) async {}),
      seed: () => NoteDetailState(note: saveUpdateNote, saveButtonStatus: SaveButtonStatus.idle, toastMessage: ''),
      build: () => noteHomeBloc,
      act: (bloc) => bloc.add(NoteDetailSaved()),
      verify: (_) {
        verify(mockUpdateNote.call(any)).called(1);
      },
    );
  });
}
