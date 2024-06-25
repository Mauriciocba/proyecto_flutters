import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_hour_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_events_metrics_use_case.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_hour_metrics_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../domain/entities/colors_limit.dart';

part 'metrics_event.dart';
part 'metrics_state.dart';

class MetricsBloc extends Bloc<MetricsEvent, MetricsState> {
  final GetLoginsEventsMetricsUseCase getLoginsEventsMetricsUseCase;
  final GetLoginsHourMetricsUseCase getLoginsHourMetricsUseCase;

  MetricsBloc({
    required this.getLoginsEventsMetricsUseCase,
    required this.getLoginsHourMetricsUseCase,
  }) : super(MetricsInitial()) {
    on<LoadMetricsLogins>(_onLoadMetricsEvents);
  }

  FutureOr<void> _onLoadMetricsEvents(LoadMetricsLogins event, emit) async {
    emit(MetricsLoading());

    final failureOrMetricsEvents =
        await getLoginsEventsMetricsUseCase.call(event.start, event.end);
    final failureOrHoursMetrics =
        await getLoginsHourMetricsUseCase.call(null, null);

    if (failureOrHoursMetrics.isLeft()) {
      return emit(MetricsFailure(
          errorMessage: failureOrHoursMetrics.getLeft().message));
    }

    final listColorsLimit = _calculateColorLimits(
      max: getMaxLogins(failureOrHoursMetrics.getRight()),
      colors: [Colors.green, Colors.yellow, Colors.red],
    );

    failureOrMetricsEvents.fold(
        (error) => emit(MetricsFailure(errorMessage: error.message)),
        (dataEventsMetrics) => emit(MetricsLoginsSuccess(
              listLoginsEventsMetrics: dataEventsMetrics,
              listLoginsHoursMetrics: failureOrHoursMetrics.getRight(),
              listColorsLimit: listColorsLimit,
            )));
  }

  List<ColorsLimit> _calculateColorLimits({
    required int max,
    required List<Color> colors,
  }) {
    final percentages = [0.3, 0.7, 1.0];
    return List<ColorsLimit>.generate(
      percentages.length,
      (i) => ColorsLimit(
        limit: max <= 2 ? 1 : (max * percentages[i]).toInt(),
        color: colors[i],
      ),
    );
  }

  int getMaxLogins(List<LoginsHourMetricsModel> eventsMetrics) {
    return eventsMetrics.fold<int>(0, (maxLogins, event) {
      if (event.logins.isNotEmpty) {
        final loginCount = int.parse(event.logins[0].loginsPerHour);
        return loginCount > maxLogins ? loginCount : maxLogins;
      }
      return maxLogins;
    });
  }
}
