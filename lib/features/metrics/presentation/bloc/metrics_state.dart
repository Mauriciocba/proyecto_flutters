part of 'metrics_bloc.dart';

sealed class MetricsState extends Equatable {
  const MetricsState();

  @override
  List<Object> get props => [];
}

final class MetricsInitial extends MetricsState {}

class MetricsLoginsSuccess extends MetricsState {
  final List<LoginsEventsMetricsModel> listLoginsEventsMetrics;
  final List<LoginsHourMetricsModel> listLoginsHoursMetrics;
  final List<ColorsLimit> listColorsLimit;

  const MetricsLoginsSuccess(
      {required this.listLoginsEventsMetrics,
      required this.listLoginsHoursMetrics,
      required this.listColorsLimit});
}

class MetricsFailure extends MetricsState {
  final String errorMessage;

  const MetricsFailure({required this.errorMessage});
}

class MetricsLoading extends MetricsState {}
