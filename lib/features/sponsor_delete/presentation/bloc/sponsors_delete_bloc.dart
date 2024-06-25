import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/use_cases/delete_sponsors_use_case.dart';

part 'sponsors_delete_event.dart';
part 'sponsors_delete_state.dart';

class SponsorsDeleteBloc
    extends Bloc<SponsorsDeleteEvent, SponsorsDeleteState> {
  final DeleteSponsorsUseCase _deleteSponsorsUseCase;
  SponsorsDeleteBloc(this._deleteSponsorsUseCase)
      : super(SponsorsDeleteInitial()) {
    on<DeleteSponsorsStart>(onDeleteSponsors);
  }

  FutureOr<void> onDeleteSponsors(DeleteSponsorsStart event, emit) async {
    emit(SponsorsDeleteLoading());

    final result = await _deleteSponsorsUseCase(event.spoId);

    result.fold((error) => emit(SponsorsDeleteFailure(msgFail: error.message)),
        (data) => emit(SponsorsDeleteSuccess()));
  }
}
