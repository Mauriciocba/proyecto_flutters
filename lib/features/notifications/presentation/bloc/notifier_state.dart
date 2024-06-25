part of 'notifier_bloc.dart';

sealed class NotifierState extends Equatable {
  const NotifierState();

  @override
  List<Object> get props => [];
}

final class NotifierInitial extends NotifierState {}

final class NotifierInProgress extends NotifierState {}

final class NotifierSuccess extends NotifierState {
  final String message;

  const NotifierSuccess({required this.message});
}

final class NotifierFailure extends NotifierState {
  final String errorMessage;

  const NotifierFailure({required this.errorMessage});
}
