import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/get_categories_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoriesBloc(this._getCategoriesUseCase) : super(CategoriesInitial()) {
    on<FetchedCategories>(_onFetchedCategories);
  }

  FutureOr<void> _onFetchedCategories(FetchedCategories event, emit) async {
    emit(CategoriesLoadInProgress());

    final failOrData = await _getCategoriesUseCase();

    failOrData.fold(
      (fail) => emit(CategoriesLoadFailure(message: fail.message)),
      (data) => emit(CategoriesLoadSuccess(categories: data)),
    );
  }
}
