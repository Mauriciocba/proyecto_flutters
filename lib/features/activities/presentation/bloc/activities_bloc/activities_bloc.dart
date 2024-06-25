import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/get_activities_by_event_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final GetActivitiesByEventUseCase _getActivitiesByEventUseCase;

  ActivitiesBloc(this._getActivitiesByEventUseCase)
      : super(const ActivitiesInitial()) {
    on<RequestedActivities>(_onRequestedActivities);
  }

  FutureOr<void> _onRequestedActivities(RequestedActivities event, emit) async {
    emit(ActivitiesOnLoading(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
      query: event.query,
    ));

    final failOrActivities = await _getActivitiesByEventUseCase(
      eventId: event.eventId,
      page: event.page,
      limit: event.limit,
      search: event.query,
    );

    if (failOrActivities.isLeft()) {
      return emit(ActivitiesLoadFailure(
        error: failOrActivities.getLeft().message,
        eventId: state.eventId,
        page: state.page,
        limit: state.limit,
        query: state.query,
      ));
    }

    return emit(ActivitiesLoadSuccess(
      activities: failOrActivities.getRight(),
      eventId: state.eventId,
      page: state.page,
      limit: state.limit,
      query: state.query,
    ));
  }
}
