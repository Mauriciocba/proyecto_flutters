part of 'metrics_bloc.dart';

sealed class MetricsEvent extends Equatable {
  const MetricsEvent();

  @override
  List<Object> get props => [];
}

class LoadMetricsLogins extends MetricsEvent {
  final DateTime? start;
  final DateTime? end;

  const LoadMetricsLogins({required this.start, required this.end});
}
