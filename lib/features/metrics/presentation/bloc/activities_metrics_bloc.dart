import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/get_events_all_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../domain/entities/activity_metric.dart';
import '../../domain/use_cases/get_activity_metrics_use_case.dart';

part 'activities_metrics_event.dart';
part 'activities_metrics_state.dart';

class ActivitiesMetricsBloc
    extends Bloc<ActivitiesMetricsEvent, ActivitiesMetricsState> {
  final GetActivityMetricsUseCase getActivityMetricsUseCase;
  final GetEventAllUseCase getEventAllUseCase;

  ActivitiesMetricsBloc(
      {required this.getActivityMetricsUseCase,
      required this.getEventAllUseCase})
      : super(ActivitiesMetricsInitial()) {
    on<LoadActivitiesMetricsEvents>(_onLoadActivitiesMetricsEvents);
  }

  FutureOr<void> _onLoadActivitiesMetricsEvents(
      LoadActivitiesMetricsEvents event,
      Emitter<ActivitiesMetricsState> emit) async {
    emit(ActivitiesMetricsLoading());

    final failureOrEvents = await getEventAllUseCase.call();

    if (failureOrEvents.isLeft()) {
      emit(ActivitiesEventFailure(message: failureOrEvents.getLeft().message));
    }
    final failOrActivitiesMetric =
        await getActivityMetricsUseCase.getActivityMetrics(
            event.eventId ?? failureOrEvents.getRight().first.eveId,
            event.startDate,
            event.endDate);

    if (failOrActivitiesMetric.isLeft()) {
      emit(ActivitiesEventFailure(
          message: failOrActivitiesMetric.getLeft().toString()));
      return;
    }

    emit(ActivitiesEventSuccess(
        lisActivityMetric: failOrActivitiesMetric.getRight(),
        listEvents: failureOrEvents.getRight()));
  }
}
