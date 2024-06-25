import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';

part 'new_activity_event.dart';
part 'new_activity_state.dart';

class NewActivityBloc extends Bloc<NewActivityEvent, NewActivityState> {
  final RegisterActivityUseCase _registerActivityUseCase;

  NewActivityBloc(this._registerActivityUseCase) : super(NewActivityInitial()) {
    on<SubmittedNewActivity>(_onSubmittedNewActivity);
  }

  Future<void> _onSubmittedNewActivity(SubmittedNewActivity event, emit) async {
    emit(NewActivityRegisterLoading());
    final result =
        await _registerActivityUseCase(activityForm: event.dataInput);

    result.fold(
        (error) =>
            emit(NewActivityRegisterFailure(errorMessage: error.message)),
        (data) => emit(
            const NewActivityRegisterSuccess(message: "Actividad registrada")));
  }
}
