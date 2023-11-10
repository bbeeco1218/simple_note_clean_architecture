import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/delete_note_use_case.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart';

part 'note_home_event.dart';
part 'note_home_state.dart';
part 'note_home_bloc.freezed.dart';

typedef NoteHomeEmitter = Emitter<NoteHomeState>;
const String deleteNoteFailMessage = 'Note delete fail';

@injectable
class NoteHomeBloc extends Bloc<NoteHomeEvent, NoteHomeState> {
  NoteHomeBloc({required this.getNotes, required this.deleteNote}) : super(const NoteHomeState()) {
    on<NoteHomeStarted>(_onStarted);
    on<NoteHomeNoteDeleted>(_onNoteDeleted);
  }

  final GetNotesUseCase getNotes;
  final DeleteNoteUseCase deleteNote;

  Future<void> _onStarted(NoteHomeStarted event, NoteHomeEmitter emit) async {
    final List<Note> notes = await getNotes.call(NoParams());

    emit(state.copyWith(notes: notes));
  }

  Future<void> _onNoteDeleted(NoteHomeNoteDeleted event, NoteHomeEmitter emit) async {
    try {
      await deleteNote.call(DeleteNoteParams(noteIdx: event.noteIdx));
      final List<Note> deletedList = [...state.notes];
      deletedList.removeWhere((element) => element.idx == event.noteIdx);
      emit(state.copyWith(notes: deletedList));
    } catch (e) {
      emit(state.copyWith(toastMessage: deleteNoteFailMessage));
    }
  }
}
