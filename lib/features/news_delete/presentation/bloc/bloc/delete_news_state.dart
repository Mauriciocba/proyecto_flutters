part of 'delete_news_bloc.dart';

sealed class DeleteNewsState extends Equatable {
  const DeleteNewsState();
  
  @override
  List<Object> get props => [];
}

final class DeleteNewsInitial extends DeleteNewsState {}

final class DeleteNewsLoading extends DeleteNewsState {}

final class DeleteNewsSuccess extends DeleteNewsState {}

final class DeleteNewsFailure extends DeleteNewsState {
  final String msgErro;

  const DeleteNewsFailure({required this.msgErro});

}