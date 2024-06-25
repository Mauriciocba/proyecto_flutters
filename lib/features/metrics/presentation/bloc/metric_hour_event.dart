part of 'metric_hour_bloc.dart';

sealed class MetricHourEvent extends Equatable {
  const MetricHourEvent();

  @override
  List<Object> get props => [];
}

class LoadMetricsHour extends MetricHourEvent {
  final int eventId;

  const LoadMetricsHour({required this.eventId});
}
