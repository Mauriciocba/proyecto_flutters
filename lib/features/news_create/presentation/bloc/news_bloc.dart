import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/news_create/domain/entities/news_model.dart';
import 'package:pamphlets_management/features/news_create/domain/use_case/register_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final RegisterNewsUseCase _registerNewsUseCase;
  NewsBloc(this._registerNewsUseCase) : super(NewsInitial()) {
    on<NewsStart>(onNews);
  }

  FutureOr<void> onNews(NewsStart event, emit) async {
    emit(NewsLoading());

    final result = await _registerNewsUseCase(event.news);

    result.fold((error) => emit(NewsFailure(msgFail: error.message)),
        (data) => emit(NewsSuccess()));
  }
}
