import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_info/domain/entities/stands_info_model.dart';
import 'package:pamphlets_management/features/stand_info/domain/use_cases/get_stands_info.dart';

part 'info_stands_event.dart';
part 'info_stands_state.dart';

class InfoStandsBloc extends Bloc<InfoStandsEvent, InfoStandsState> {
  final GetStandsInfoUseCase _getStandsInfoUseCase;
  InfoStandsBloc(this._getStandsInfoUseCase) : super(InfoStandsInitial()) {
    on<InfoStandsStart>(onInfoStands);
  }

  FutureOr<void> onInfoStands(InfoStandsStart event, emit) async {
    emit(InfoStandsLoading());

    final response = await _getStandsInfoUseCase(event.eventId);

    response.fold((error) => emit(InfoStandsFailure(msgFail: error)),
        (data) => emit(InfoStandsSuccess(listStands: data)));
  }
}
