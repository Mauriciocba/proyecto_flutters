import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/faq/data/model/faq_response.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class FaqRepositoryImpl implements FaqRepository {
  final ApiService _apiService;

  FaqRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, Faq>> saveFaqByEvent({
    required String question,
    required String answer,
    required int eventId,
  }) async {
    final response = await _apiService.request(
      method: HttpMethod.post,
      url: '/faqs/create',
      body: {
        "faq_question": question,
        "faq_answer": answer,
        "eve_id": eventId,
      },
    );

    if (response.resultType == ResultType.error) {
      return Left(
          BaseFailure(message: 'No se pudo realizar la solicitud al servidor'));
    }

    if (response.resultType == ResultType.failure) {
      return Left(
          BaseFailure(message: 'Hubo una falla en la obtención de datos'));
    }

    if (response.body == null || response.body?['data'] == null) {
      return Left(
          BaseFailure(message: 'No se pudo obtener los datos solicitados'));
    }

    final data = response.body?['data'];

    final faqResponse = FaqResponse.fromJson(data);
    final faq = Faq(
      faqId: faqResponse.faqId,
      question: faqResponse.faqQuestion,
      answer: faqResponse.faqAnswer,
      eventId: faqResponse.eveId,
      images: [],
    );

    return Right(faq);
  }
}
