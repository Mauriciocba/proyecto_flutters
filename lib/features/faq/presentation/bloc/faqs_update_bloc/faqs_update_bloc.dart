import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/data/model/faq_response.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq_form.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/update_faq_use_case.dart';

part 'faqs_update_event.dart';
part 'faqs_update_state.dart';

class FaqsUpdateBloc extends Bloc<FaqsUpdateEvent, FaqsUpdateState> {
  final UpdateFaqUseCase _updateFaqUseCase;

  FaqsUpdateBloc(this._updateFaqUseCase) : super(FaqsUpdateInitial()) {
    on<FaqsUpdateStarted>(_onFaqUpdateStarted);
    on<FaqsUpdatePressed>(_onFaqUpdatePressed);
  }

  FutureOr<void> _onFaqUpdateStarted(FaqsUpdateStarted event, emit) {
    emit(FaqsUpdateFormLoaded(faqForm: event.faqForm));
  }

  FutureOr<void> _onFaqUpdatePressed(FaqsUpdatePressed event, emit) async {
    emit(FaqsUpdateLoading());

    final failOrData = await _updateFaqUseCase(
      newFaqData: event.faqsData,
      currentImages: event.currentImages,
    );

    failOrData.fold(
      (fail) => emit(FaqsUpdateFailure(message: fail.message)),
      (data) => emit(FaqsUpdateSuccess()),
    );
  }
}
