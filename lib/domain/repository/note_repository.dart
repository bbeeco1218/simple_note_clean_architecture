import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';

abstract class NoteRepository {
  final NoteRemoteDataSource remoteDataSource;
  const NoteRepository({required this.remoteDataSource});

  Future<List<Note>> getNotes();
  Future<Note> getNoteByIdx(int idx);
  Future<int> insertNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(int noteIdx);
  // bool validateInsert(Note note);
  // bool validateTitle(String title);
  // bool validateDesc(String desc);
  // bool validateIdx(int noteIdx);
}
