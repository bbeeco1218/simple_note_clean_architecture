import 'package:equatable/equatable.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

class GetNoteUseCase implements UseCase<Note, GetNoteParams> {
  final NoteRepository noteRepository;
  GetNoteUseCase({required this.noteRepository});

  @override
  Future<Note> call(GetNoteParams params) async {
    return await noteRepository.getNoteByIdx(params.noteIdx);
  }
}

class GetNoteParams extends Equatable {
  final int noteIdx;

  const GetNoteParams({required this.noteIdx});
  @override
  List<Object?> get props => [noteIdx];
}
