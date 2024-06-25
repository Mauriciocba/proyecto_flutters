part of 'select_activity_bloc.dart';

sealed class SelectActivityState extends Equatable {
  const SelectActivityState();

  @override
  List<Object> get props => [];
}

final class SelectActivityInitial extends SelectActivityState {}

class LoadNewEventFailure extends SelectActivityState {
  final String errorMessage;

  const LoadNewEventFailure({required this.errorMessage});
}

class LoadNewEventLoading extends SelectActivityState {}

class LoadNewEventSuccess extends SelectActivityState {
  final List<ActivityMetric> listActivity;

  const LoadNewEventSuccess({required this.listActivity});
}
