part of 'category_updater_bloc.dart';

sealed class CategoryUpdaterEvent extends Equatable {
  const CategoryUpdaterEvent();

  @override
  List<Object> get props => [];
}

final class CategoryUpdaterPressed extends CategoryUpdaterEvent {
  final int categoryId;
  final CategoryRegistrationForm newData;

  const CategoryUpdaterPressed({
    required this.categoryId,
    required this.newData,
  });
}

final class CategoryUpdaterLoadedForm extends CategoryUpdaterEvent {
  final Category category;

  const CategoryUpdaterLoadedForm(this.category);
}
