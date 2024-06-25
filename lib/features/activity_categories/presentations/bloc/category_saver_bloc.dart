import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category_registration_form.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/register_new_category_use_case.dart';

part 'category_saver_event.dart';
part 'category_saver_state.dart';

class CategorySaverBloc extends Bloc<CategorySaverEvent, CategorySaverState> {
  final RegisterNewCategoryUseCase _registerNewCategoryUseCase;

  CategorySaverBloc(this._registerNewCategoryUseCase)
      : super(CategorySaverInitial()) {
    on<SavedNewCategory>(_onSavedNewCategory);
  }

  FutureOr<void> _onSavedNewCategory(SavedNewCategory event, emit) async {
    emit(CategorySaverLoadInProgress());

    final failOrData = await _registerNewCategoryUseCase(
      event.categoryRegistrationForm,
    );

    failOrData.fold(
      (fail) => emit(CategorySaverLoadFailure(message: fail.message)),
      (data) => emit(CategorySaverLoadSuccess(category: data)),
    );
  }
}
