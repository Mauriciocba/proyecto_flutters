part of 'edit_activity_bloc.dart';

sealed class EditActivityEvent extends Equatable {
  const EditActivityEvent();

  @override
  List<Object> get props => [];
}

class EditActivityStarted extends EditActivityEvent {
  final Activity activity;

  const EditActivityStarted({required this.activity});
}

class EditActivityConfirmed extends EditActivityEvent {
  final int activityId;
  final ActivityFormInput activityFormData;

  const EditActivityConfirmed({
    required this.activityId,
    required this.activityFormData,
  });
}
