// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/data/repository/note_repository_impl.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';

void main() {
  group('note repositoryimpl', () {
    final NoteRepositoryImpl noteRepository = NoteRepositoryImpl();
    test('get notes', () {
      final List<Note> noteList = [
        Note.empty(),
        Note.empty(),
      ];

      expect(noteRepository.getNotes(), noteList);
    });

    // test('get note by id', () {
    //   expect(noteRepository.getNoteById(idx: 0), const Note(title: '', desc: '', color: 0, idx: 0));
    // });

    // test('insert note', () {
    //   expect(noteRepository.insertNote(Note.empty().copyWith(title: '1', desc: '1')), true);
    // });

    // test('validate insert', () {
    //   expect(noteRepository.validateInsert(Note.empty()), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1')), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(desc: '1')), false);
    //   expect(noteRepository.validateInsert(Note.empty().copyWith(title: '1', desc: '1')), true);
    // });

    // test('validate title', () {
    //   expect(noteRepository.validateTitle(''), false);
    //   expect(noteRepository.validateTitle('1'), true);
    // });

    // test('validate desc', () {
    //   expect(noteRepository.validateDesc(''), false);
    //   expect(noteRepository.validateDesc('1'), true);
    // });

    // test('validate idx', () {
    //   expect(noteRepository.validateIdx(-1), false);
    //   expect(noteRepository.validateIdx(1), true);
    // });

    // test('update note', () {
    //   // expect(noteRepository.updateNote(Note.empty()), false);
    //   // expect(noteRepository.updateNote(Note.empty().copyWith(title: '', desc: '', idx: 1)), false);
    //   expect(noteRepository.updateNote(Note.empty().copyWith(title: '1', desc: '1', idx: 1)), true);
    // });

    // test('delete note', () {
    //   // expect(noteRepository.deleteNote(-1), false);
    //   expect(noteRepository.deleteNote(1), true);
    // });
  });
}
