part of 'metric_hour_bloc.dart';

sealed class MetricHourState extends Equatable {
  const MetricHourState();

  @override
  List<Object> get props => [];
}

final class MetricHourInitial extends MetricHourState {}

class MetricsHourFailure extends MetricHourState {
  final String errorMessage;

  const MetricsHourFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class MetricsHourLoading extends MetricHourState {}

class MetricsHourSuccess extends MetricHourState {
  final LoginsHourMetricsModel? loginsHourMetricsModel;

  const MetricsHourSuccess({required this.loginsHourMetricsModel});
}
