import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/speakers_info/domain/entities/speakers_info_model.dart';
import 'package:pamphlets_management/features/speakers_info/domain/use_case/speakers_info_use_case.dart';

part 'speakers_info_event.dart';
part 'speakers_info_state.dart';

class SpeakersInfoBloc extends Bloc<SpeakersInfoEvent, SpeakersInfoState> {
  final GetSpeakersInfoUseCase _getSpeakersInfoUseCase;
  SpeakersInfoBloc(this._getSpeakersInfoUseCase)
      : super(SpeakersInfoInitial()) {
    on<SpeakersOnStart>(speakersOnStart);
  }

  FutureOr<void> speakersOnStart(SpeakersOnStart event, emit) async {
    emit(SpeakersInfoLoading(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
      query: event.search,
    ));

    final speakersOrFail = await _getSpeakersInfoUseCase(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
      search: event.search,
    );

    speakersOrFail.fold(
      (error) => emit(SpeakersInfoFailure(
        msgError: error.message,
        eventId: state.eventId,
        page: state.page,
        limit: state.limit,
        query: state.query,
      )),
      (speakerList) => emit(SpeakersInfoSuccess(
        listSpeakers: speakerList,
        page: state.page,
        limit: state.limit,
        query: state.query,
      )),
    );
  }
}
