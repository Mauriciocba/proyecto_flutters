import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_activities_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_events_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_speakers_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_users_download_use_case.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final GetEventsDownloadUseCase _eventDownloadUseCase;
  final GetActivitiesDownloadUseCase _activitiesDownloadUseCase;
  final GetSpeakersDownloadUseCase _speakersDownloadUseCase;
  final GetUsersDownloadUseCase _usersDownloadUseCase;
  DownloadBloc(this._eventDownloadUseCase, this._activitiesDownloadUseCase,
      this._usersDownloadUseCase, this._speakersDownloadUseCase)
      : super(DownloadInitial()) {
    on<RequestedDownloadEvents>(_onRequestedDownloadEvents);
    on<RequestedDownloadEvent>(_onRequestedDownloadEvent);
    on<RequestedDownloadActivity>(_onRequestedDownloadActivity);
    on<RequestedDownloadSpeakers>(_onRequestedDownloadSpeakers);
    on<RequestedDownloadUsers>(_onRequestedDownloadUsers);
  }

  FutureOr<void> _onRequestedDownloadEvents(
      RequestedDownloadEvents event, Emitter<DownloadState> emit) async {
    final failOrData = await _eventDownloadUseCase.call();
    failOrData.fold((fail) => emit(DownloadFailure(errorMessage: fail.message)),
        (accounts) => {});
  }

  FutureOr<void> _onRequestedDownloadActivity(
      RequestedDownloadActivity event, Emitter<DownloadState> emit) async {
    final failOrData =
        await _activitiesDownloadUseCase.call(event.eventId, event.eventName);
    failOrData.fold((fail) => emit(DownloadFailure(errorMessage: fail.message)),
        (accounts) => {});
  }

  FutureOr<void> _onRequestedDownloadSpeakers(
      RequestedDownloadSpeakers event, Emitter<DownloadState> emit) async {
    final failOrData =
        await _speakersDownloadUseCase.call(event.eventId, event.eventName);
    failOrData.fold((fail) => emit(DownloadFailure(errorMessage: fail.message)),
        (accounts) => {});
  }

  FutureOr<void> _onRequestedDownloadUsers(
      RequestedDownloadUsers event, Emitter<DownloadState> emit) async {
    final failOrData =
        await _usersDownloadUseCase.call(event.eventId, event.eventName);
    failOrData.fold((fail) => emit(DownloadFailure(errorMessage: fail.message)),
        (accounts) => {});
  }

  FutureOr<void> _onRequestedDownloadEvent(
      RequestedDownloadEvent event, Emitter<DownloadState> emit) async {
    for (var type in event.items) {
      switch (type.value) {
        case PopupMenuItemsGroup.activity:
          final failOrActivities = await _activitiesDownloadUseCase.call(
              event.eventId, event.eventName);
          failOrActivities.fold(
              (fail) =>
                  emit(DownloadActivitiesFailure(errorMessage: fail.message)),
              (accounts) => {});
          break;
        case PopupMenuItemsGroup.speakers:
          final failOrSpeakers = await _speakersDownloadUseCase.call(
              event.eventId, event.eventName);
          failOrSpeakers.fold(
              (fail) =>
                  emit(DownloadSpeakersFailure(errorMessage: fail.message)),
              (accounts) => {});
          break;
        case PopupMenuItemsGroup.users:
          final failOrUsers =
              await _usersDownloadUseCase.call(event.eventId, event.eventName);
          failOrUsers.fold(
              (fail) => emit(DownloadUsersFailure(errorMessage: fail.message)),
              (accounts) => {});
          break;
        default:
      }
    }
    emit(DownloadFinished());
  }
}
