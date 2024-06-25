import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/delete_news_use_case.dart';

part 'delete_news_event.dart';
part 'delete_news_state.dart';

class DeleteNewsBloc extends Bloc<DeleteNewsEvent, DeleteNewsState> {
  final DeleteNewsUseCase _deleteNewsUseCase;
  DeleteNewsBloc(this._deleteNewsUseCase) : super(DeleteNewsInitial()) {
    on<DeleteNews>(onDeleteNews);
  }

  FutureOr<void> onDeleteNews(DeleteNews event, emit) async {
    emit(DeleteNewsLoading());

    final failOrDeleteNews = await _deleteNewsUseCase(event.newsId);

    failOrDeleteNews.fold(
        (error) => emit(DeleteNewsFailure(msgErro: error.message)),
        (data) => emit(DeleteNewsSuccess()));
  }
}
