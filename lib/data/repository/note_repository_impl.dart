import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
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
  Future<Note?> getNoteByIdx({required int idx}) async {
    return await remoteDataSource.getNoteByIdx(idx);
  }

  @override
  Future<int> insertNote(Note note) async {
    return await remoteDataSource.insertNote(note);
  }

  @override
  Future<bool> updateNote(Note note) async {
    final int numberOfChanges = await remoteDataSource.updateNote(note);
    return numberOfChanges == 1;
  }

  @override
  Future<bool> deleteNote(int idx) async {
    final int numberOfAffected = await remoteDataSource.deleteNote(idx);
    return numberOfAffected == 1;
  }
}
