// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/domain/model/note.dart';

void main() {
  group('note repository', () {
    final NoteRepository noteRepository = NoteRepository();
    test('get notes', () {
      final List<Note> noteList = [
        Note.empty(),
        Note.empty(),
      ];

      expect(noteRepository.getNotes(), noteList);
    });

    test('get note by id', () {
      expect(noteRepository.getNoteById(idx: 0), const Note(title: '', desc: '', color: 0, idx: 0));
    });

    test('insert note', () {
      expect(noteRepository.insertNote(Note.empty().copyWith(title: '1', desc: '1')), true);
    });

    test('validate insert', () {
      expect(noteRepository.validateInsert(Note.empty()), false);
      expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1')), false);
      expect(noteRepository.validateInsert(Note.empty().copyWith(desc: '1')), false);
      expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1', desc: '1')), true);
    });

    test('validate title', () {
      expect(noteRepository.validateTitle(Note.empty()), false);

      expect(noteRepository.validateTitle(Note.empty().copyWith(title: '')), false);

      expect(noteRepository.validateTitle(Note.empty().copyWith(title: '1')), true);
    });

    test('validate desc', () {
      expect(noteRepository.validateDesc(Note.empty()), false);
      expect(noteRepository.validateDesc(Note.empty().copyWith(title: '')), false);
      expect(noteRepository.validateDesc(Note.empty().copyWith(desc: '1')), true);
    });
  });
}

class NoteRepository {
  List<Note> getNotes() {
    return [
      Note.empty(),
      Note.empty(),
    ];
  }

  Note getNoteById({required int idx}) {
    return const Note(title: '', desc: '', color: 0, idx: 0);
  }

  bool insertNote(Note note) {
    if (!validateInsert(note)) return false;
    return true;
  }

  bool validateInsert(Note note) {
    if (!validateTitle(note)) return false;
    if (!validateDesc(note)) return false;
    return true;
  }

  bool validateTitle(Note note) {
    if (note.title.isEmpty) return false;
    return true;
  }

  bool validateDesc(Note note) {
    if (note.desc.isEmpty) return false;
    return true;
  }
}
