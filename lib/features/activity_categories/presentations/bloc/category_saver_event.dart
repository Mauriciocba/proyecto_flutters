part of 'category_saver_bloc.dart';

sealed class CategorySaverEvent extends Equatable {
  const CategorySaverEvent();

  @override
  List<Object> get props => [];
}

final class SavedNewCategory extends CategorySaverEvent {
  final CategoryRegistrationForm categoryRegistrationForm;

  const SavedNewCategory({required this.categoryRegistrationForm});
}
