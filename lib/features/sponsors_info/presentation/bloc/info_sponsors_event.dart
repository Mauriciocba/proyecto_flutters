part of 'info_sponsors_bloc.dart';

sealed class InfoSponsorsEvent extends Equatable {
  const InfoSponsorsEvent();

  @override
  List<Object> get props => [];
}

class InfoSponsorsStart extends InfoSponsorsEvent {
  final int eventId;

  const InfoSponsorsStart({required this.eventId});

}