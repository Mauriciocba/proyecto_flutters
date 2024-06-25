import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/get_sponsors_category_use_case.dart';

part 'sponsors_category_event.dart';
part 'sponsors_category_state.dart';

class SponsorsCategoryBloc
    extends Bloc<SponsorsCategoryEvent, SponsorsCategoryState> {
  final GetSponsorsCategoryUseCase _getSponsorsCategoryUseCase;
  SponsorsCategoryBloc(this._getSponsorsCategoryUseCase)
      : super(SponsorsCategoryInitial()) {
    on<CategorySponsorsStart>(onCategorySponsors);
  }

  FutureOr<void> onCategorySponsors(CategorySponsorsStart event, emit) async {
    emit(SponsorsCategoryLoading());

    final result = await _getSponsorsCategoryUseCase(event.eventId);

    result.fold((error) => emit(SponsorsCategoryFailure(msgFail: error)),
        (data) => emit(SponsorsCategorySuccess(lstCategorySponsor: data)));
  }
}
