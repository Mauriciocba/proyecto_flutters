part of 'activities_metrics_bloc.dart';

sealed class ActivitiesMetricsState {}

final class ActivitiesMetricsInitial extends ActivitiesMetricsState {}

final class ActivitiesMetricsLoading extends ActivitiesMetricsState {}

class ActivitiesEventSuccess extends ActivitiesMetricsState {
  final List<ActivityMetric> lisActivityMetric;
  final List<Event> listEvents;

  ActivitiesEventSuccess(
      {required this.lisActivityMetric, required this.listEvents});
}

class ActivitiesEventFailure extends ActivitiesMetricsState {
  final String message;

  ActivitiesEventFailure({required this.message});
}
