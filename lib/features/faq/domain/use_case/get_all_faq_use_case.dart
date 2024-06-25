import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_get_all_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class GetAllFaqUseCase {
  final FaqGetAllRepository _faqGetAllRepository;

  GetAllFaqUseCase(this._faqGetAllRepository);

  Future<Either<BaseFailure, List<Faq>>> call({required int eventId}) async {
    return _faqGetAllRepository.getAllByEvent(eventId);
  }
}
