part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsSuccess extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsFailure extends NewsState {
  final String msgFail;

  const NewsFailure({required this.msgFail});
}
