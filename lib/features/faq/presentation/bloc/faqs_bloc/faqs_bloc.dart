// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/get_all_faq_use_case.dart';

part 'faqs_event.dart';
part 'faqs_state.dart';

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  final GetAllFaqUseCase _getAllFaqUseCase;

  FaqsBloc(
    this._getAllFaqUseCase,
  ) : super(FaqsInitial()) {
    on<FaqsStarted>(_onFaqsStarted);
  }

  FutureOr<void> _onFaqsStarted(
    FaqsStarted event,
    Emitter<FaqsState> emit,
  ) async {
    emit(FaqsLoading());

    await Future.delayed(const Duration(seconds: 2));

    final dataOrFail = await _getAllFaqUseCase.call(eventId: event.eventId);

    dataOrFail.fold(
      (fail) => emit(FaqsFailure(message: fail.message)),
      (data) => emit(FaqsSuccess(faqs: data)),
    );
  }
}
