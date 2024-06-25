import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class DeleteFaqUseCase {
  final FaqDeleteRepository _faqDeleteRepository;

  DeleteFaqUseCase({required FaqDeleteRepository faqDeleteRepository})
      : _faqDeleteRepository = faqDeleteRepository;

  Future<Either<BaseFailure, bool>> call({required int faqId}) async {
    try {
      return await _faqDeleteRepository.deleteBy(faqId: faqId);
    } catch (e) {
      return const Right(false);
    }
  }
}
