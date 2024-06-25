import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/edit_activity_use_case.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

part 'edit_activity_event.dart';
part 'edit_activity_state.dart';

class EditActivityBloc extends Bloc<EditActivityEvent, EditActivityState> {
  final EditActivityUseCase _editActivityUseCase;

  EditActivityBloc(this._editActivityUseCase) : super(EditActivityInitial()) {
    on<EditActivityStarted>(_onEditActivityStarted);
    on<EditActivityConfirmed>(_onEditActivityConfirmed);
  }

  FutureOr<void> _onEditActivityStarted(EditActivityStarted event, emit) async {
    emit(EditActivityLoadInProgress());

    emit(EditActivityLoadSuccess(oldActivity: event.activity));
  }

  FutureOr<void> _onEditActivityConfirmed(
      EditActivityConfirmed event, emit) async {
    //mostrar el loading
    emit(EditActivityLoadInProgress());

    // enviar los datos de la nueva confirmación
    final result = await _editActivityUseCase(
      activityFormInput: event.activityFormData,
      activityId: event.activityId,
    );

    //recibir la respuesta de confirmación

    if (result.isLeft()) {
      return emit(EditActivityFailure(errorMessage: result.getLeft().message));

      //?enviar estado inicial
    }

    emit(EditActivitySuccess());
  }
}
