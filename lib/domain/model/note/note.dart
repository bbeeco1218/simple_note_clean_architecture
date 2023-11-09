import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_note_clean_architecture/core/theme/app_colors.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String title,
    required String desc,
    required int color,
    int? idx,
    DateTime? createAt,
    DateTime? updateAt,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.empty() => Note(title: '', desc: '', color: AppColors.darkGray.value);
}
