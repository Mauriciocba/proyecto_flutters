part of 'event_all_bloc.dart';

sealed class EventAllState {}

final class EventAllInitial extends EventAllState {}

final class EventAllSuccess extends EventAllState {
  final List<Event> event;

  EventAllSuccess({required this.event});
}

final class EventAllLoading extends EventAllState {}

final class EventAllFailure extends EventAllState {
  final String message;

  EventAllFailure({required this.message});
}

final class NotLoggedIn extends EventAllState {}
