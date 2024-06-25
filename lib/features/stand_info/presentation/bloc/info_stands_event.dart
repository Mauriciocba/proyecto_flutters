part of 'info_stands_bloc.dart';

sealed class InfoStandsEvent extends Equatable {
  const InfoStandsEvent();

  @override
  List<Object> get props => [];
}

class InfoStandsStart extends InfoStandsEvent {
  final int eventId;

  const InfoStandsStart({required this.eventId});
}
