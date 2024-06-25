part of 'available_position_bloc.dart';

sealed class AvailablePositionEvent extends Equatable {
  const AvailablePositionEvent();

  @override
  List<Object> get props => [];
}

class AvailablePositionStarted extends AvailablePositionEvent {
  const AvailablePositionStarted();
}
