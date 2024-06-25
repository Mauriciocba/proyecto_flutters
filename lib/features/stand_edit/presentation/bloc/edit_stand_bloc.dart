import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/domain/use_cases/edit_stand_use_case.dart';

part 'edit_stand_event.dart';
part 'edit_stand_state.dart';

class EditStandBloc extends Bloc<EditStandEvent, EditStandState> {
  final EditStandsUseCase _editStandsUseCase;
  EditStandBloc(this._editStandsUseCase) : super(EditStandInitial()) {
    on<EditStandsStart>(onEditStands);
    on<EditStandConfirmed>(onLoadStands);
  }

  FutureOr<void> onEditStands(EditStandsStart event, emit) {
    emit(EditStandLoading());

    emit(LoadStandsEditSuccess(standEdit: event.standEditModel));
  }

  FutureOr<void> onLoadStands(EditStandConfirmed event, emit) async {
    emit(EditStandLoading());

    final result = await _editStandsUseCase(
        modelStands: StandsEditModel(
            stdId: event.standEdit.stdId,
            stdName: event.standEdit.stdName,
            stdNameCompany: event.standEdit.stdNameCompany,
            stdDescription: event.standEdit.stdDescription,
            stdNumber: event.standEdit.stdNumber,
            stdReferent: event.standEdit.stdReferent,
            stdStartup: event.standEdit.stdStartup,
            stdLogo: event.standEdit.stdLogo));

    result.fold(
        (error) =>
            emit(LoadStandsEditFail(msgFailLoadFormStand: error.message)),
        (data) => emit(EditStandSuccess()));
  }
}
