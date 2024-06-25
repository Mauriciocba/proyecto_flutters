part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsStart extends NewsEvent {
  final NewsModel news;

  const NewsStart({required this.news});
}