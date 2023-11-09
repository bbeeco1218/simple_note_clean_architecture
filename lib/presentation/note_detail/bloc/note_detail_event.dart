part of 'note_detail_bloc.dart';

class NoteDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteDetailStarted extends NoteDetailEvent {
  final Note note;

  NoteDetailStarted({required this.note});

  @override
  List<Object?> get props => [note];
}

class NoteDetailColorChanged extends NoteDetailEvent {
  final Color color;

  NoteDetailColorChanged({required this.color});
  @override
  List<Object?> get props => [color];
}

class NoteDetailSaved extends NoteDetailEvent {}
