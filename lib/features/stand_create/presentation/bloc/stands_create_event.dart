part of 'stands_create_bloc.dart';

sealed class StandsCreateEvent extends Equatable {
  const StandsCreateEvent();

  @override
  List<Object> get props => [];
}

class StandsStart extends StandsCreateEvent {
  final StandsModel stdModel;

  const StandsStart({required this.stdModel});
}