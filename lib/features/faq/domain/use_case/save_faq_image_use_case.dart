import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/image_faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_save_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class SaveFaqImageUseCase {
  final FaqImageSaveRepository _faqImageSaveRepository;

  SaveFaqImageUseCase(this._faqImageSaveRepository);

  Future<Either<BaseFailure, ImageFaq>> call({
    required int faqId,
    required String image,
  }) async {
    try {
      return await _faqImageSaveRepository.save(faqId: faqId, image: image);
    } catch (e) {
      throw Left(BaseFailure(message: 'No se pudo completar la operación'));
    }
  }
}
