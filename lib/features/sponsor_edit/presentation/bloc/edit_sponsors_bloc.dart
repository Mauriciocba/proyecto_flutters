import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/use_cases/edit_sponsor_use_case.dart';

part 'edit_sponsors_event.dart';
part 'edit_sponsors_state.dart';

class EditSponsorsBloc extends Bloc<EditSponsorsEvent, EditSponsorsState> {
  final EditSponsorsUseCase _editSponsorsUseCase;
  EditSponsorsBloc(this._editSponsorsUseCase) : super(EditSponsorsInitial()) {
    on<EditSponsorStart>(onEditSponsorsStart);
    on<EditSponsorConfirmed>(onEditSponsorConfirmed);
  }

  FutureOr<void> onEditSponsorsStart(EditSponsorStart event, emit) {
    emit(EditSponsorsLoading());

    emit(LoadSponsorsSuccess(spoModel: event.sponsorStart));
  }

  FutureOr<void> onEditSponsorConfirmed(
      EditSponsorConfirmed event, emit) async {
    emit(EditSponsorsLoading());

    final result = await _editSponsorsUseCase(
        modelSponsors: SponsorsEditModel(
            spoId: event.spoModel.spoId,
            eveId: event.spoModel.eveId,
            spcId: event.spoModel.spcId,
            spoName: event.spoModel.spoName,
            spoDescription: event.spoModel.spoDescription,
            spoLogo: event.spoModel.spoLogo,
            spoUrl: event.spoModel.spoUrl));

    result.fold((error) => emit(EditSponsorsFail(msgFail: error.message)),
        (data) => emit(EditSponsorsSuccess()));
  }
}
