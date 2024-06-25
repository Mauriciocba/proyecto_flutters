part of 'delete_activity_bloc.dart';

sealed class DeleteActivityState {}

final class DeleteActivityInitial extends DeleteActivityState {}

class DeleteActivityFailure extends DeleteActivityState {
  final String errorMessage;

  DeleteActivityFailure({required this.errorMessage});
}

class DeleteActivityLoading extends DeleteActivityState {}

class DeleteActivitySuccess extends DeleteActivityState {}
