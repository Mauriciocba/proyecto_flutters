import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_delete/domain/use_cases/delete_stand_use_case.dart';

part 'delete_stands_event.dart';
part 'delete_stands_state.dart';

class DeleteStandsBloc extends Bloc<DeleteStandsEvent, DeleteStandsState> {
  final DeleteStandUseCase _deleteStandUseCase;
  DeleteStandsBloc(this._deleteStandUseCase) : super(DeleteStandsInitial()) {
    on<DeleteStandStart>(onDeleteStand);
  }

  FutureOr<void> onDeleteStand(DeleteStandStart event, emit) async {
    emit(DeleteStandLoading());

    final result = await _deleteStandUseCase(event.stdId);

    result.fold((error) => emit(DeleteStandFailure(msgError: error.message)),
        (data) => emit(DeleteStandSuccess()));
  }
}
