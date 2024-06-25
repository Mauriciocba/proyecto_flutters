part of 'category_remover_bloc.dart';

sealed class CategoryRemoverState extends Equatable {
  const CategoryRemoverState();

  @override
  List<Object> get props => [];
}

final class CategoryRemoverInitial extends CategoryRemoverState {}

final class CategoryRemoverSuccess extends CategoryRemoverState {
  final String message;

  const CategoryRemoverSuccess({required this.message});
}

final class CategoryRemoverFailure extends CategoryRemoverState {
  final String message;

  const CategoryRemoverFailure({required this.message});
}

final class CategoryRemoverInProgress extends CategoryRemoverState {}
