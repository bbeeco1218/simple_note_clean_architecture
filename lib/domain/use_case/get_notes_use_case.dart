import 'package:injectable/injectable.dart';
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

@Singleton(as: UseCase)
class GetNotesUseCase implements UseCase<List<Note>, NoParams> {
  final NoteRepository noteRepository;
  GetNotesUseCase({required this.noteRepository});

  @override
  Future<List<Note>> call(params) {
    return noteRepository.getNotes();
  }
}
