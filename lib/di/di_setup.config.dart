// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:simple_note_clean_architecture/core/use_case/use_case.dart'
    as _i12;
import 'package:simple_note_clean_architecture/data/data_source/note_remote_data_source.dart'
    as _i9;
import 'package:simple_note_clean_architecture/data/repository/note_repository_impl.dart'
    as _i11;
import 'package:simple_note_clean_architecture/di/app_module.dart' as _i15;
import 'package:simple_note_clean_architecture/domain/model/note/note.dart'
    as _i13;
import 'package:simple_note_clean_architecture/domain/repository/note_repository.dart'
    as _i10;
import 'package:simple_note_clean_architecture/domain/use_case/delete_note_use_case.dart'
    as _i8;
import 'package:simple_note_clean_architecture/domain/use_case/get_note_use_case.dart'
    as _i14;
import 'package:simple_note_clean_architecture/domain/use_case/get_notes_use_case.dart'
    as _i7;
import 'package:simple_note_clean_architecture/domain/use_case/update_note_use_case.dart'
    as _i5;
import 'package:simple_note_clean_architecture/presentation/note_detail/bloc/note_detail_bloc.dart'
    as _i4;
import 'package:simple_note_clean_architecture/presentation/note_home/bloc/note_home_bloc.dart'
    as _i6;
import 'package:sqflite/sqflite.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.Database>(
      () => appModule.db,
      preResolve: true,
    );
    gh.factory<_i4.NoteDetailBloc>(
        () => _i4.NoteDetailBloc(updateNote: gh<_i5.UpdateNoteUseCase>()));
    gh.factory<_i6.NoteHomeBloc>(() => _i6.NoteHomeBloc(
          getNotes: gh<_i7.GetNotesUseCase>(),
          deleteNote: gh<_i8.DeleteNoteUseCase>(),
        ));
    gh.singleton<_i9.NoteRemoteDataSource>(
        _i9.NoteRemoteDataSourceImpl(db: gh<_i3.Database>()));
    gh.singleton<_i10.NoteRepository>(_i11.NoteRepositoryImpl(
        remoteDataSource: gh<_i9.NoteRemoteDataSource>()));
    gh.singleton<_i12.UseCase<List<_i13.Note>, _i12.NoParams>>(
        _i7.GetNotesUseCase(noteRepository: gh<_i10.NoteRepository>()));
    gh.singleton<_i12.UseCase<_i13.Note, _i14.GetNoteParams>>(
        _i14.GetNoteUseCase(noteRepository: gh<_i10.NoteRepository>()));
    gh.singleton<_i12.UseCase<void, _i5.UpdateNoteParams>>(
        _i5.UpdateNoteUseCase(noteRepository: gh<_i10.NoteRepository>()));
    gh.singleton<_i12.UseCase<void, _i8.DeleteNoteParams>>(
        _i8.DeleteNoteUseCase(noteRepository: gh<_i10.NoteRepository>()));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
