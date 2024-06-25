import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class DeleteFaqImageUseCase {
  final FaqImageDeleteRepository _faqImageDeleteRepository;

  DeleteFaqImageUseCase(this._faqImageDeleteRepository);

  Future<Either<BaseFailure, bool>> call({required int imageFaqId}) async {
    try {
      return await _faqImageDeleteRepository.deleteBy(imageFaqId);
    } catch (e) {
      debugPrint('$e');
      return Left(BaseFailure(message: 'No se pudo completar la operación'));
    }
  }
}
