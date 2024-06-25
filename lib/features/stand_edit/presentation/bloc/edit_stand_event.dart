part of 'edit_stand_bloc.dart';

sealed class EditStandEvent extends Equatable {
  const EditStandEvent();

  @override
  List<Object> get props => [];
}

class EditStandConfirmed extends EditStandEvent {
  final StandsEditModel standEdit;

  const EditStandConfirmed({required this.standEdit});
}

class EditStandsStart extends EditStandEvent {
  final StandsEditModel standEditModel;

  const EditStandsStart({required this.standEditModel});
}

class RequestedEditStands extends EditStandEvent {
  final int eventId;

  const RequestedEditStands({required this.eventId});
}