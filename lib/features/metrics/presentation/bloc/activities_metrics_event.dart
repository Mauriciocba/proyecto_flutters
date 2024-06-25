part of 'activities_metrics_bloc.dart';

sealed class ActivitiesMetricsEvent extends Equatable {
  const ActivitiesMetricsEvent();
  @override
  List<Object> get props => [];
}

class LoadActivitiesMetricsEvents extends ActivitiesMetricsEvent {
  final int? eventId;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadActivitiesMetricsEvents(
      {required this.eventId, this.startDate, this.endDate});
}
