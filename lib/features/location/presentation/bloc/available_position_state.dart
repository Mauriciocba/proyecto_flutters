part of 'available_position_bloc.dart';

sealed class AvailablePositionState extends Equatable {
  const AvailablePositionState();

  @override
  List<Object> get props => [];
}

final class AvailablePositionInitial extends AvailablePositionState {}

final class AvailablePositionResult extends AvailablePositionState {
  final bool available;
  const AvailablePositionResult({required this.available});
}
