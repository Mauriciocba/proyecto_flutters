import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/news_info/domain/entities/news_model.dart';
import 'package:pamphlets_management/features/news_info/domain/use_cases/news_info_use_case.dart';

part 'news_info_event.dart';
part 'news_info_state.dart';

class NewsInfoBloc extends Bloc<NewsInfoEvent, NewsInfoState> {
  final GetNewsInfoUseCase _getNewsInfoUseCase;
  NewsInfoBloc(this._getNewsInfoUseCase) : super(NewsInfoInitial()) {
    on<NewsInfoStart>(onNewsInfo);
  }

  FutureOr<void> onNewsInfo(NewsInfoStart event, emit) async {
    emit(NewsInfoLoading());

    final failOrNewsInfo = await _getNewsInfoUseCase(event.eventId);

    failOrNewsInfo.fold(
        (error) => emit(NewsInfoFailure(msgFail: error.message)),
        (listNewsInfo) => emit(NewsInfoSuccess(listNews: listNewsInfo)));
  }
}
