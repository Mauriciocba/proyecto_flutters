part of 'create_event_bloc.dart';

sealed class CreateEventState {}

final class CreateEventInitial extends CreateEventState {}

class CreateEventFailure extends CreateEventState {
  final String errorMessage;

  CreateEventFailure({required this.errorMessage});
}

class CreateEventLoading extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {}
