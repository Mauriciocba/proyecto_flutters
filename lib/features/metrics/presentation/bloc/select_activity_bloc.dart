import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/activity_metric.dart';
import '../../domain/use_cases/get_activity_metrics_use_case.dart';

part 'select_activity_event.dart';
part 'select_activity_state.dart';

class SelectActivityBloc
    extends Bloc<SelectActivityEvent, SelectActivityState> {
  final GetActivityMetricsUseCase getActivityMetricsUseCase;

  SelectActivityBloc({required this.getActivityMetricsUseCase})
      : super(SelectActivityInitial()) {
    on<LoadNewEvent>(_onLoadNewEvent);
  }

  FutureOr<void> _onLoadNewEvent(LoadNewEvent event, emit) async {
    emit(LoadNewEventLoading());

    final failOrActivitiesMetric = await getActivityMetricsUseCase
        .getActivityMetrics(event.eventId, event.startDate, event.endDate);

    failOrActivitiesMetric.fold(
        (error) => emit(LoadNewEventFailure(errorMessage: error.message)),
        (data) => emit(LoadNewEventSuccess(listActivity: data)));
  }
}
