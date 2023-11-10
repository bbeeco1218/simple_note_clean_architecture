// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:simple_note_clean_architecture/domain/model/note/note.dart';
import 'package:simple_note_clean_architecture/domain/use_case/update_note_use_case.dart';

part 'note_detail_bloc.freezed.dart';
part 'note_detail_event.dart';
part 'note_detail_state.dart';

typedef NoteDetailEmitter = Emitter<NoteDetailState>;
const String emptyTitleMessage = '제목을 입력해 주세요.';
const String emptyDescMessage = '내용을 입력해 주세요.';

@injectable
class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailState> {
  NoteDetailBloc({
    required this.updateNote,
  }) : super(NoteDetailState.initial()) {
    on<NoteDetailStarted>(_onStarted);
    on<NoteDetailColorChanged>(_onColorChanged);
    on<NoteDetailSaved>(_onSaved);
  }

  final UpdateNoteUseCase updateNote;

  void _onStarted(NoteDetailStarted event, NoteDetailEmitter emit) {
    emit(state.copyWith(note: event.note));
  }

  void _onColorChanged(NoteDetailColorChanged event, NoteDetailEmitter emit) {
    final Note newNote = state.note.copyWith(color: event.color.value);
    emit(state.copyWith(note: newNote));
  }

  Future<void> _onSaved(_, NoteDetailEmitter emit) async {
    try {
      emit(state.copyWith(saveButtonStatus: SaveButtonStatus.loading));
      await saveNote();
      emit(state.copyWith(saveButtonStatus: SaveButtonStatus.idle));
    } on ValidateNoteException catch (e) {
      emit(state.copyWith(
        saveButtonStatus: SaveButtonStatus.idle,
        toastMessage: e.message,
      ));
    }
  }

  Future<bool> saveNote() async {
    if (!validateTitle(state.note)) throw ValidateNoteException(message: emptyTitleMessage);
    if (!validateDesc(state.note)) throw ValidateNoteException(message: emptyDescMessage);

    if (state.note.idx == null) {
      return true;
      // insertnote
    }

    await updateNote.call(UpdateNoteParams(note: state.note));
    return true;
  }

  bool validateTitle(Note note) => note.title.isNotEmpty;

  bool validateDesc(Note note) => note.desc.isNotEmpty;
}

class ValidateNoteException implements Exception {
  final String message;

  ValidateNoteException({required this.message});
}
