part of 'category_updater_bloc.dart';

sealed class CategoryUpdaterState extends Equatable {
  const CategoryUpdaterState();

  @override
  List<Object> get props => [];
}

final class CategoryUpdaterInitial extends CategoryUpdaterState {}

final class CategoryUpdaterLoadSuccess extends CategoryUpdaterState {}

final class CategoryUpdaterLoadFailure extends CategoryUpdaterState {
  final String message;

  const CategoryUpdaterLoadFailure(this.message);
}

final class CategoryUpdaterInProgress extends CategoryUpdaterState {}

final class CategoryUpdaterLoadForm extends CategoryUpdaterState {
  final Category category;

  const CategoryUpdaterLoadForm(this.category);
}
