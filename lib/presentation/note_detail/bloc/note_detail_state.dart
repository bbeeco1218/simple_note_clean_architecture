part of 'note_detail_bloc.dart';

@freezed
class NoteDetailState with _$NoteDetailState {
  const factory NoteDetailState({
    required Note note,
    required SaveButtonStatus saveButtonStatus,
    required String toastMessage,
  }) = _NoteDetailState;

  factory NoteDetailState.initial() {
    return NoteDetailState(
      note: Note.empty(),
      saveButtonStatus: SaveButtonStatus.idle,
      toastMessage: '',
    );
  }
}

enum SaveButtonStatus {
  idle,
  loading,
}
