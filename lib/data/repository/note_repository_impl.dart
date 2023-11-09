import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_failure.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  @override
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Note>> getNotes() async {
    return await remoteDataSource.getNotes();
  }

  @override
  Future<Note> getNoteByIdx(int idx) async {
    final Note? result = await remoteDataSource.getNoteByIdx(idx);
    if (result == null) throw NoteRepositoryFailure();
    return result;
  }

  @override
  Future<int> insertNote(Note note) async {
    final int idx = await remoteDataSource.insertNote(note);
    if (idx == 0) throw NoteRepositoryFailure();
    return idx;
  }

  @override
  Future<void> updateNote(Note note) async {
    final int numberOfChanges = await remoteDataSource.updateNote(note);
    if (numberOfChanges == 0) throw NoteRepositoryFailure();
  }

  @override
  Future<void> deleteNote(int idx) async {
    final int numberOfAffected = await remoteDataSource.deleteNote(idx);
    if (numberOfAffected == 0) throw NoteRepositoryFailure();
  }
}
