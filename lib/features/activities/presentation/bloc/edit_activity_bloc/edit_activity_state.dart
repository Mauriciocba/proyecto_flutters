part of 'edit_activity_bloc.dart';

sealed class EditActivityState extends Equatable {
  const EditActivityState();

  @override
  List<Object> get props => [];
}

final class EditActivityInitial extends EditActivityState {}

final class EditActivityLoadSuccess extends EditActivityState {
  final Activity oldActivity;

  const EditActivityLoadSuccess({required this.oldActivity});
}

final class EditActivityLoadFailure extends EditActivityState {
  final String errorMessage;

  const EditActivityLoadFailure({required this.errorMessage});
}

final class EditActivityLoadInProgress extends EditActivityState {}

final class EditActivitySuccess extends EditActivityState {}

final class EditActivityFailure extends EditActivityState {
  final String errorMessage;

  const EditActivityFailure({required this.errorMessage});
}
