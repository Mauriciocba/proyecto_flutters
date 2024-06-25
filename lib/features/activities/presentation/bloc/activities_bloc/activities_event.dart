part of 'activities_bloc.dart';

sealed class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class RequestedActivities extends ActivitiesEvent {
  final int eventId;
  final int? page;
  final int? limit;
  final String? query;

  const RequestedActivities({
    required this.eventId,
    this.page,
    this.limit,
    this.query,
  });
}
