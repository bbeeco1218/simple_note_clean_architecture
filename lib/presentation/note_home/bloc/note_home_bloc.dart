import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart';

part 'note_home_event.dart';
part 'note_home_state.dart';
part 'note_home_bloc.freezed.dart';

typedef NoteHomeEmitter = Emitter<NoteHomeState>;

class NoteHomeBloc extends Bloc<NoteHomeEvent, NoteHomeState> {
  NoteHomeBloc(this.getNotes) : super(const NoteHomeState()) {
    on<NoteHomeStarted>(_onStarted);
  }

  final GetNotesUseCase getNotes;

  Future<void> _onStarted(NoteHomeStarted event, NoteHomeEmitter emit) async {
    final List<Note> notes = await getNotes.call(NoParams());
    emit(state.copyWith(notes: notes));
  }
}
