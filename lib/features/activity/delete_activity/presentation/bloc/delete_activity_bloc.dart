import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity/delete_activity/domain/use_cases/delete_activity_use_case.dart';

part 'delete_activity_event.dart';
part 'delete_activity_state.dart';

class DeleteActivityBloc
    extends Bloc<DeleteActivityEvent, DeleteActivityState> {
  final DeleteActivityUseCase _deleteActivityUseCase;

  DeleteActivityBloc(this._deleteActivityUseCase)
      : super(DeleteActivityInitial()) {
    on<DeleteActivity>(_onDeleteActivity);
  }

  FutureOr<void> _onDeleteActivity(DeleteActivity event, emit) async {
    emit(DeleteActivityLoading());

    final failureOrDelete = await _deleteActivityUseCase(event.activityId);

    failureOrDelete.fold(
        (error) => emit(DeleteActivityFailure(errorMessage: error.message)),
        (data) => emit(DeleteActivitySuccess()));
  }
}
