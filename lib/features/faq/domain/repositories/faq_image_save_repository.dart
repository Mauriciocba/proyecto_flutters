import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/image_faq.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class FaqImageSaveRepository {
  Future<Either<BaseFailure, ImageFaq>> save({
    required int faqId,
    required String image,
  });
}
