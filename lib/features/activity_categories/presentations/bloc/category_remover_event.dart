part of 'category_remover_bloc.dart';

sealed class CategoryRemoverEvent extends Equatable {
  const CategoryRemoverEvent();

  @override
  List<Object> get props => [];
}

final class CategoryRemoverPressed extends CategoryRemoverEvent {
  final int categoryId;

  const CategoryRemoverPressed({required this.categoryId});
}
