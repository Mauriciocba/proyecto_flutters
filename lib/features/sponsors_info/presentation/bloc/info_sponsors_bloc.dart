import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/entities/sponsors_info_model.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/use_cases/get_sponsors_use_cases.dart';

part 'info_sponsors_event.dart';
part 'info_sponsors_state.dart';

class InfoSponsorsBloc extends Bloc<InfoSponsorsEvent, InfoSponsorsState> {
  final GetSponsorsInfoUseCase _getSponsorsInfoUseCase;
  InfoSponsorsBloc(this._getSponsorsInfoUseCase)
      : super(InfoSponsorsInitial()) {
    on<InfoSponsorsStart>(onInfoSponsors);
  }

  FutureOr<void> onInfoSponsors(InfoSponsorsStart event, emit) async {
    emit(InfoSponsorsLoading());

    final result = await _getSponsorsInfoUseCase(event.eventId);

    result.fold((error) => emit(InfoSponsorsFailure(msgFail: error)),
        (data) => emit(InfoSponsorsSuccess(listSponsors: data)));
  }
}
