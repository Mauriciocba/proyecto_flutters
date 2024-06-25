import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/delete_category_use_case.dart';

part 'category_remover_event.dart';
part 'category_remover_state.dart';

class CategoryRemoverBloc
    extends Bloc<CategoryRemoverEvent, CategoryRemoverState> {
  final DeleteCategoryUseCase _deleteCategoryUseCase;

  CategoryRemoverBloc(this._deleteCategoryUseCase)
      : super(CategoryRemoverInitial()) {
    on<CategoryRemoverPressed>(_onRemoverPressed);
  }

  FutureOr<void> _onRemoverPressed(
    CategoryRemoverPressed event,
    Emitter<CategoryRemoverState> emit,
  ) async {
    emit(CategoryRemoverInProgress());

    final failOrData = await _deleteCategoryUseCase.call(event.categoryId);

    failOrData.fold(
      (fail) => emit(CategoryRemoverFailure(message: fail.message)),
      (data) => emit(
        const CategoryRemoverSuccess(message: "Categoría eliminada"),
      ),
    );
  }
}
