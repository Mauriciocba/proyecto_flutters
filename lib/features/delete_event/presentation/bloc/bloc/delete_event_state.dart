part of 'delete_event_bloc.dart';

sealed class DeleteEventState extends Equatable {
  const DeleteEventState();

  @override
  List<Object> get props => [];
}

final class DeleteEventInitial extends DeleteEventState {}

final class LoadingDeleteEvent extends DeleteEventState {}

final class SuccessDeleteEvent extends DeleteEventState {}

final class FailureDeleteEvent extends DeleteEventState {
  final String message;

  const FailureDeleteEvent({required this.message});
}
