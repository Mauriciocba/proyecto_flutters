import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/edit_sponsors_category_use_case.dart';

part 'sponsors_category_edit_event.dart';
part 'sponsors_category_edit_state.dart';

class SponsorsCategoryEditBloc
    extends Bloc<SponsorsCategoryEditEvent, SponsorsCategoryEditState> {
  final EditSponsorsCategoryUseCase _editSponsorsCategoryUseCase;
  SponsorsCategoryEditBloc(this._editSponsorsCategoryUseCase)
      : super(SponsorsCategoryEditInitial()) {
    on<CategoryUpdaterPressed>(onCategoryUpdaterLoadedForm);
    on<CategoryUpdaterLoadedForm>(onCategoryUpdateLoadedForm);
  }

  FutureOr<void> onCategoryUpdaterLoadedForm(CategoryUpdaterPressed event,
      Emitter<SponsorsCategoryEditState> emit) async {
    emit(SponsorsCategoryEditLoading());

    final failOrData = await _editSponsorsCategoryUseCase(
        categoryId: event.categoryId, spcModel: event.newData);

    failOrData.fold(
        (error) =>
            emit(SponsorsCategoryEditLoadFailure(msgFail: error.message)),
        (success) => emit(SponsorsCategoryEditLoadSuccess()));
  }

  FutureOr<void> onCategoryUpdateLoadedForm(CategoryUpdaterLoadedForm event,
      Emitter<SponsorsCategoryEditState> emit) async {
    emit(SponsorsCategoryUpdaterLoadForm(spcEdit: event.SpoCategory));
  }
}
