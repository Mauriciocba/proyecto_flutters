part of 'edit_sponsors_bloc.dart';

sealed class EditSponsorsState extends Equatable {
  const EditSponsorsState();
  
  @override
  List<Object> get props => [];
}

final class EditSponsorsInitial extends EditSponsorsState {}

class EditSponsorsSuccess extends EditSponsorsState {}

class EditSponsorsLoading extends EditSponsorsState {}

class EditSponsorsFail extends EditSponsorsState {
  final String msgFail;

  const EditSponsorsFail({required this.msgFail});

}

//load sponsors

class LoadSponsorsSuccess extends EditSponsorsState {
  final SponsorsEditModel spoModel;

  const LoadSponsorsSuccess({required this.spoModel});
}

class LoadSponsorsLoading extends EditSponsorsState {}

class LoadSponsorsFailure extends EditSponsorsState {
    final String msgFail;

  const LoadSponsorsFailure({required this.msgFail});
}
