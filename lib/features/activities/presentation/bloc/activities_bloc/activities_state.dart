part of 'activities_bloc.dart';

sealed class ActivitiesState extends Equatable {
  final int? eventId;
  final int? page;
  final int? limit;
  final String? query;

  const ActivitiesState({this.eventId, this.page, this.limit, this.query});

  @override
  List<Object> get props => [];
}

final class ActivitiesInitial extends ActivitiesState {
  const ActivitiesInitial({
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}

final class ActivitiesOnLoading extends ActivitiesState {
  const ActivitiesOnLoading({
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}

final class ActivitiesLoadSuccess extends ActivitiesState {
  final Iterable<Activity> activities;

  const ActivitiesLoadSuccess({
    required this.activities,
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}

final class ActivitiesLoadFailure extends ActivitiesState {
  final String error;

  const ActivitiesLoadFailure({
    required this.error,
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}
