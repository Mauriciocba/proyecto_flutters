part of 'stands_create_bloc.dart';

sealed class StandsCreateState extends Equatable {
  const StandsCreateState();

  @override
  List<Object> get props => [];
}

final class StandsCreateInitial extends StandsCreateState {}

class StandsCreateSuccess extends StandsCreateState {}

class StandsCreateFailure extends StandsCreateState {
  final String msgFail;

  const StandsCreateFailure({required this.msgFail});
}

class StandsCreateLoading extends StandsCreateState {}
