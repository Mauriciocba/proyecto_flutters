part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadInProgress extends CategoriesState {}

final class CategoriesLoadSuccess extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoadSuccess({required this.categories});
}

final class CategoriesLoadFailure extends CategoriesState {
  final String message;

  const CategoriesLoadFailure({required this.message});
}
