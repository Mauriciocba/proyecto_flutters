import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/logins_hour_metrics_model.dart';
import '../../domain/use_cases/get_logins_hour_metrics_use_case.dart';

part 'metric_hour_event.dart';
part 'metric_hour_state.dart';

class MetricHourBloc extends Bloc<MetricHourEvent, MetricHourState> {
  final GetLoginsHourMetricsUseCase getLoginsHourMetricsUseCase;

  MetricHourBloc({required this.getLoginsHourMetricsUseCase})
      : super(MetricHourInitial()) {
    on<LoadMetricsHour>(onLoadMetricHour);
  }
  FutureOr<void> onLoadMetricHour(LoadMetricsHour event, emit) async {
    emit(MetricsHourLoading());

    final failureOrMetricsHour =
        await getLoginsHourMetricsUseCase.call(null, null);

    failureOrMetricsHour.fold(
        (error) => emit(MetricsHourFailure(errorMessage: error.message)),
        (data) => _getInfoMetricsHour(data, event, emit));
  }

  void _getInfoMetricsHour(
      List<LoginsHourMetricsModel> data, LoadMetricsHour event, emit) {
    if (data.isNotEmpty) {
      final infoMetricsHour =
          data.where((element) => element.eventId == event.eventId).first;
      emit(MetricsHourSuccess(loginsHourMetricsModel: infoMetricsHour));
    } else {
      emit(const MetricsHourSuccess(loginsHourMetricsModel: null));
    }
  }
}
