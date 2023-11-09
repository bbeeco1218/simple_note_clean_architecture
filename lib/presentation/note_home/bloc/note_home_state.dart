part of 'note_home_bloc.dart';

@freezed
class NoteHomeState with _$NoteHomeState {
  const factory NoteHomeState({
    @Default([]) List<Note> notes,
    @Default('') String toastMessage,
  }) = _NoteHomeState;
}
