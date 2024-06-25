part of 'delete_news_bloc.dart';

sealed class DeleteNewsEvent extends Equatable {
  const DeleteNewsEvent();

  @override
  List<Object> get props => [];
}

class DeleteNews extends DeleteNewsEvent {
  final int newsId;

  const DeleteNews({required this.newsId});
}