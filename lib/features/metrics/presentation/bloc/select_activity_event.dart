part of 'select_activity_bloc.dart';

sealed class SelectActivityEvent extends Equatable {
  const SelectActivityEvent();

  @override
  List<Object> get props => [];
}

class LoadNewEvent extends SelectActivityEvent {
  final int eventId;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadNewEvent(
      {required this.eventId, required this.startDate, required this.endDate});
}
