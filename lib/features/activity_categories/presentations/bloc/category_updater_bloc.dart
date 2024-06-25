import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/update_category_use_case.dart';

part 'category_updater_event.dart';
part 'category_updater_state.dart';

class CategoryUpdaterBloc
    extends Bloc<CategoryUpdaterEvent, CategoryUpdaterState> {
  final UpdateCategoryUseCase _updateCategoryUseCase;

  CategoryUpdaterBloc(this._updateCategoryUseCase)
      : super(CategoryUpdaterInitial()) {
    on<CategoryUpdaterPressed>(_onCategoryUpdater);
    on<CategoryUpdaterLoadedForm>(_onCategoryUpdaterEdit);
  }

  FutureOr<void> _onCategoryUpdater(
    CategoryUpdaterPressed event,
    Emitter<CategoryUpdaterState> emit,
  ) async {
    emit(CategoryUpdaterInProgress());

    final failOrData = await _updateCategoryUseCase(
      categoryId: event.categoryId,
      newCategoryData: event.newData,
    );

    failOrData.fold(
      (fail) => emit(CategoryUpdaterLoadFailure(fail.message)),
      (success) => emit(CategoryUpdaterLoadSuccess()),
    );
  }

  FutureOr<void> _onCategoryUpdaterEdit(
    CategoryUpdaterLoadedForm event,
    Emitter<CategoryUpdaterState> emit,
  ) async {
    emit(CategoryUpdaterLoadForm(event.category));
  }
}
