import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/faq/domain/domain/image_faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_save_repository.dart';
import 'package:pamphlets_management/utils/common/encode_image_file.dart';

import '../../../../core/errors/base_failure.dart';

final class FaqImageSaveRepositoryImpl implements FaqImageSaveRepository {
  final ApiService _apiService;

  FaqImageSaveRepositoryImpl(this._apiService);

  @override
  Future<Either<BaseFailure, ImageFaq>> save({
    required int faqId,
    required String image,
  }) async {
    try {
      final encodedImage = await encodeImageFile(image);

      final response = await _apiService.request(
        method: HttpMethod.post,
        url: '/image-faqs/create',
        body: {
          'ifq_image': encodedImage,
          'faq_id': faqId,
        },
      );

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return Left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }

      if (response.body == null || response.body?['data'] == null) {
        return Left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      final imageFaq = ImageFaq(
        imageFaqId: response.body?['data']['faq_id'],
        image: response.body?['data']['ifq_image'],
      );

      return Right(imageFaq);
    } catch (e) {
      debugPrint('$e');
      return Left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
