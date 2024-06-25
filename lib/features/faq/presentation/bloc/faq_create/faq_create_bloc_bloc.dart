import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/create_faq_use_case.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/save_faq_image_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

part 'faq_create_bloc_event.dart';
part 'faq_create_bloc_state.dart';

class FaqCreateBloc extends Bloc<FaqCreateEvent, FaqCreateState> {
  final CreateFaqUseCase _createFaqUseCase;
  final SaveFaqImageUseCase _saveFaqImageUseCase;

  FaqCreateBloc(this._createFaqUseCase, this._saveFaqImageUseCase)
      : super(FaqCreateBlocInitial()) {
    on<FaqCreatePressed>(_onCreateFaqPressed);
  }

  FutureOr<void> _onCreateFaqPressed(
    FaqCreatePressed event,
    Emitter<FaqCreateState> emit,
  ) async {
    emit(FaqCreateBlocLoading());

    final failOrFAQ = await _createFaqUseCase(
      answer: event.answer,
      question: event.question,
      eventId: event.eventId,
    );

    if (failOrFAQ.isLeft()) {
      return emit(FaqCreateBlocFailure(message: failOrFAQ.getLeft().message));
    }

    final faq = failOrFAQ.getRight();

    for (var urlImage in event.urlImages) {
      final failOrImage = await _saveFaqImageUseCase(
        faqId: faq.faqId,
        image: urlImage,
      );

      if (failOrImage.isLeft()) {
        return emit(
          FaqCreateBlocFailure(message: failOrImage.getLeft().message),
        );
      }
    }

    emit(FaqCreateBlocSuccess(faqModel: faq));
  }
}
