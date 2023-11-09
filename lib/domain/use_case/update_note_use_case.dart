import 'package:equatable/equatable.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

class UpdateNoteUseCase implements UseCase<void, UpdateNoteParams> {
  final NoteRepository noteRepository;
  UpdateNoteUseCase({required this.noteRepository});

  @override
  Future<void> call(UpdateNoteParams params) async {
    return await noteRepository.updateNote(params.note);
  }
}

class UpdateNoteParams extends Equatable {
  final Note note;

  const UpdateNoteParams({required this.note});
  @override
  List<Object?> get props => [note];
}
