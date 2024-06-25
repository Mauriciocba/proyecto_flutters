part of 'news_info_bloc.dart';

sealed class NewsInfoState extends Equatable {
  const NewsInfoState();

  @override
  List<Object> get props => [];
}

final class NewsInfoInitial extends NewsInfoState {}

final class NewsInfoSuccess extends NewsInfoState {
  final List<NewsModel> listNews;

  const NewsInfoSuccess({required this.listNews});
}

final class NewsInfoLoading extends NewsInfoState {}

final class NewsInfoFailure extends NewsInfoState {
  final String msgFail;

  const NewsInfoFailure({required this.msgFail});
}
