part of 'new_activity_bloc.dart';

sealed class NewActivityState extends Equatable {
  const NewActivityState();

  @override
  List<Object> get props => [];
}

final class NewActivityInitial extends NewActivityState {}

final class NewActivityRegisterLoading extends NewActivityState {}

final class NewActivityRegisterSuccess extends NewActivityState {
  final String message;

  const NewActivityRegisterSuccess({required this.message});
}

final class NewActivityRegisterFailure extends NewActivityState {
  final String errorMessage;

  const NewActivityRegisterFailure({required this.errorMessage});
}
