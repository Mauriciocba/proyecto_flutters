part of 'info_sponsors_bloc.dart';

sealed class InfoSponsorsState extends Equatable {
  const InfoSponsorsState();
  
  @override
  List<Object> get props => [];
}

final class InfoSponsorsInitial extends InfoSponsorsState {}

class InfoSponsorsSuccess extends InfoSponsorsState {
  final List<Sponsor> listSponsors;

  const InfoSponsorsSuccess({required this.listSponsors});
}

class InfoSponsorsFailure extends InfoSponsorsState {
  final String msgFail;

  const InfoSponsorsFailure({required this.msgFail});

}

class InfoSponsorsLoading extends InfoSponsorsState {}
