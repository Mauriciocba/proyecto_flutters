import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/faq/data/model/faq_response.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_get_all_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class FaqGetAllRepositoryImpl implements FaqGetAllRepository {
  final ApiService _apiService;

  FaqGetAllRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<Faq>>> getAllByEvent(int eventId) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.get,
        url: '/faqs/event/$eventId',
      );

      if (response.body == null || response.body?['data'] == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      final faqListResponse = listFaqResponseFromJson(
        jsonEncode(response.body?['data']),
      );

      final faqList = faqListResponse
          .map(
            (faqResponse) => Faq(
              faqId: faqResponse.faqId,
              question: faqResponse.faqQuestion,
              answer: faqResponse.faqAnswer,
              eventId: faqResponse.eveId,
              images: faqResponse.imageFaqs
                  .map(
                    (imageResponse) => ImageFaq(
                      ifqId: imageResponse.ifqId,
                      ifqImage: imageResponse.ifqImage,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList();

      return Right(faqList);
    } catch (e) {
      debugPrint("$e");
      return Left(BaseFailure(message: "Hubo un fallo interno"));
    }
  }
}
