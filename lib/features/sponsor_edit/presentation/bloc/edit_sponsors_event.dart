part of 'edit_sponsors_bloc.dart';

sealed class EditSponsorsEvent extends Equatable {
  const EditSponsorsEvent();

  @override
  List<Object> get props => [];
}

class EditSponsorConfirmed extends EditSponsorsEvent {
  final SponsorsEditModel spoModel;

  const EditSponsorConfirmed({required this.spoModel});
}

class EditSponsorStart extends EditSponsorsEvent {
  final SponsorsEditModel sponsorStart;

  const EditSponsorStart({required this.sponsorStart});
}

class RequestedEditSponsor extends EditSponsorsEvent {
  final int eventId;

  const RequestedEditSponsor({required this.eventId});
}