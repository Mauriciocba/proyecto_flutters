import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class CreateFaqUseCase {
  final FaqRepository _faqRepository;

  CreateFaqUseCase({required FaqRepository faqRepository})
      : _faqRepository = faqRepository;

  Future<Either<BaseFailure, Faq>> call({
    required String question,
    required String answer,
    required int eventId,
  }) async {
    if (question.isEmpty || question.trim().isEmpty) {
      return Left(BaseFailure(message: "La pregunta no es válida"));
    }

    if (answer.isEmpty || answer.trim().isEmpty) {
      return Left(BaseFailure(message: "La respuesta no es válida"));
    }

    if (eventId.isNegative) {
      return Left(BaseFailure(message: "El evento no existe"));
    }

    return await _faqRepository.saveFaqByEvent(
      answer: answer,
      question: question,
      eventId: eventId,
    );
  }
}
