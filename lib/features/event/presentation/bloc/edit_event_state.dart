part of 'edit_event_bloc.dart';

sealed class EditEventState extends Equatable {
  const EditEventState();

  @override
  List<Object> get props => [];
}

final class EditEventInitial extends EditEventState {}

class EditEventFailure extends EditEventState {
  final String errorMessage;

  const EditEventFailure({required this.errorMessage});
}

class EditEventSuccess extends EditEventState {
  final Event eventSelected;

  const EditEventSuccess({required this.eventSelected});
}

class EditEventLoading extends EditEventState {}

class EditEventConfirmChange extends EditEventState {}

class EditEventConfirmFailure extends EditEventState {
  final String errorMessage;

  const EditEventConfirmFailure({required this.errorMessage});
}
