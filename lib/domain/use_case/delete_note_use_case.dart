import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

@Singleton(as: UseCase)
class DeleteNoteUseCase implements UseCase<void, DeleteNoteParams> {
  final NoteRepository noteRepository;
  DeleteNoteUseCase({required this.noteRepository});

  @override
  Future<void> call(DeleteNoteParams params) async {
    return await noteRepository.deleteNote(params.noteIdx);
  }
}

class DeleteNoteParams extends Equatable {
  final int noteIdx;

  const DeleteNoteParams({required this.noteIdx});
  @override
  List<Object?> get props => [noteIdx];
}
