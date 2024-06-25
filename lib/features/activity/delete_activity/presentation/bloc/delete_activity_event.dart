part of 'delete_activity_bloc.dart';

sealed class DeleteActivityEvent {}

class DeleteActivity extends DeleteActivityEvent {
  final int activityId;

  DeleteActivity({required this.activityId});
}
