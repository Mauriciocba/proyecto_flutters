part of 'category_saver_bloc.dart';

sealed class CategorySaverState extends Equatable {
  const CategorySaverState();

  @override
  List<Object> get props => [];
}

final class CategorySaverInitial extends CategorySaverState {}

final class CategorySaverLoadInProgress extends CategorySaverState {}

final class CategorySaverLoadSuccess extends CategorySaverState {
  final Category category;

  const CategorySaverLoadSuccess({required this.category});
}

final class CategorySaverLoadFailure extends CategorySaverState {
  final String message;

  const CategorySaverLoadFailure({required this.message});
}
