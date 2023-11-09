import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note_clean_architecture/core/theme/app_colors.dart';
import 'package:simple_note_clean_architecture/domain/model/note/note.dart';

void main() {
  group('note test', () {
    test('empty note', () {
      expect(Note.empty(), Note(title: '', desc: '', color: AppColors.darkGray.value));
    });
  });
}
