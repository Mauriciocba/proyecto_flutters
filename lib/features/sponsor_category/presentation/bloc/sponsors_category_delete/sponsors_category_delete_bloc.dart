import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/delete_sponsors_category_use_case.dart';

part 'sponsors_category_delete_event.dart';
part 'sponsors_category_delete_state.dart';

class SponsorsCategoryDeleteBloc
    extends Bloc<SponsorsCategoryDeleteEvent, SponsorsCategoryDeleteState> {
  final DeleteSponsorsCategoryUseCase _deleteSponsorsCategoryUseCase;
  SponsorsCategoryDeleteBloc(this._deleteSponsorsCategoryUseCase)
      : super(SponsorsCategoryDeleteInitial()) {
    on<SponsorsDeleteStart>(onDeleteSponsorsCategory);
  }

  FutureOr<void> onDeleteSponsorsCategory(
      SponsorsDeleteStart event, emit) async {
    emit(SponsorsDeleteLoading());

    final result = await _deleteSponsorsCategoryUseCase(event.spcId);

    result.fold((error) => emit(SponsorsDeleteFailure(msgFail: error.message)),
        (data) => emit(SponsorsDeleteSuccess()));
  }
}
