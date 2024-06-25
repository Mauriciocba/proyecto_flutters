import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_delete_repository.dart';

import '../../../../core/errors/base_failure.dart';

class DeleteSponsorsCategoryUseCase {
  final SponsorsCategoryDeleteRepository _sponsorsCategoryDeleteRepository;

  DeleteSponsorsCategoryUseCase(this._sponsorsCategoryDeleteRepository);

  Future<Either<BaseFailure, bool>> call(int spcId) async {
    try {
      return await _sponsorsCategoryDeleteRepository
          .deleteSponsorsCategory(spcId);
    } catch (e) {
      return left(BaseFailure(message: 'Ocurrió un error'));
    }
  }
}
