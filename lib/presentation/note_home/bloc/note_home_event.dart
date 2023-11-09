part of 'note_home_bloc.dart';

abstract class NoteHomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteHomeStarted extends NoteHomeEvent {}

class NoteHomeNoteDeleted extends NoteHomeEvent {
  final int noteIdx;

  NoteHomeNoteDeleted({required this.noteIdx});

  @override
  List<Object?> get props => [noteIdx];
}
