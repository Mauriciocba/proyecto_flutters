part of 'info_event_bloc.dart';

sealed class InfoEventState {}

final class InfoEventInitial extends InfoEventState {}

class InfoEventLoading extends InfoEventState {}

class InfoEventSuccess extends InfoEventState {
  final Event event;

  InfoEventSuccess({required this.event});
}

class InfoEventFailure extends InfoEventState {
  final String message;

  InfoEventFailure({required this.message});
}
