import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  @override
  List<Note> getNotes() {
    return [
      Note.empty(),
      Note.empty(),
    ];
  }

  @override
  Note getNoteById({required int idx}) {
    return const Note(title: '', desc: '', color: 0, idx: 0);
  }

  @override
  bool insertNote(Note note) {
    // if (!validateInsert(note)) return false;
    return true;
  }

  // @override
  // bool validateInsert(Note note) {
  //   if (!validateTitle(note.title)) return false;
  //   if (!validateDesc(note.desc)) return false;
  //   return true;
  // }

  // @override
  // bool validateTitle(String title) {
  //   if (title.isEmpty) return false;
  //   return true;
  // }

  // @override
  // bool validateDesc(String desc) {
  //   if (desc.isEmpty) return false;
  //   return true;
  // }

  // @override
  // bool validateIdx(int noteIdx) {
  //   if (noteIdx == -1) return false;
  //   return true;
  // }

  @override
  bool updateNote(Note note) {
    // if (!validateIdx(note.idx)) return false;
    // if (!validateInsert(note)) return false;
    return true;
  }

  @override
  bool deleteNote(int noteIdx) {
    // if (!validateIdx(noteIdx)) return false;
    return true;
  }
}
