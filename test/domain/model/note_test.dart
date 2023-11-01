import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/domain/model/note.dart';

void main() {
  group('note test', () {
    test('empty note', () {
      expect(Note.empty(), Note(title: '', desc: '', color: 0, idx: -1));
    });
  });
}
