import 'package:simple_note_clean_architecture/domain/model/note/note.dart';

abstract class NoteRepository {
  List<Note> getNotes();
  Note getNoteById({required int idx});
  bool insertNote(Note note);
  // bool validateInsert(Note note);
  // bool validateTitle(String title);
  // bool validateDesc(String desc);
  // bool validateIdx(int noteIdx);
  bool updateNote(Note note);
  bool deleteNote(int noteIdx);
}
