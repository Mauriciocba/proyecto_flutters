import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/register_sponsors_category_use_cases.dart';

part 'sponsors_category_create_event.dart';
part 'sponsors_category_create_state.dart';

class SponsorsCategoryCreateBloc
    extends Bloc<SponsorsCategoryCreateEvent, SponsorsCategoryCreateState> {
  final RegisterSponsorsCategoryUseCase _registerSponsorsCategoryUseCase;
  SponsorsCategoryCreateBloc(this._registerSponsorsCategoryUseCase)
      : super(SponsorsCategoryCreateInitial()) {
    on<SponsorsCategoryStart>(onSponsorsCategory);
  }

  FutureOr<void> onSponsorsCategory(SponsorsCategoryStart event, emit) async {
    emit(SponsorsCategoryCreateLoading());

    final result = await _registerSponsorsCategoryUseCase(event.spcRegister);

    result.fold(
        (error) => emit(SponsorsCategoryCreateFailure(msgFail: error.message)),
        (data) => emit(SponsorsCategoryCreateSuccess(spcModel: data)));
  }
}
