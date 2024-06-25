import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_edit_repository.dart';

import '../../../../core/errors/base_failure.dart';

class EditSponsorsCategoryUseCase {
  final SponsorsCategoryEditRepository _sponsorsCategoryEditRepository;

  EditSponsorsCategoryUseCase(this._sponsorsCategoryEditRepository);

  Future<Either<BaseFailure, SponsorsCategoryModel>> call(
      {required int categoryId,
      required SponsorsCategoryRegistrationForm spcModel}) async {
    try {
      return await _sponsorsCategoryEditRepository.loadSponsorsCategory(
          categoryId: categoryId, newCategoryData: spcModel);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo editar'));
    }
  }
}
