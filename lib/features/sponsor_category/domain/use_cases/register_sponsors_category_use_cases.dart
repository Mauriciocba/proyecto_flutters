import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_create_repository.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

class RegisterSponsorsCategoryUseCase {
  final SponsorCategoryCreateRepository _sponsorCategoryRepository;

  RegisterSponsorsCategoryUseCase(this._sponsorCategoryRepository);

  Future<Either<BaseFailure, SponsorsCategoryModel>> call(
      SponsorsCategoryRegistrationForm spcModel) async {
    final failOrCategoryId = await _sponsorCategoryRepository.save(spcModel);

    if (failOrCategoryId.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar la categoría"));
    }

    final savedCategorySponsor = SponsorsCategoryModel(
      spcId: failOrCategoryId.getRight(),
      spcName: spcModel.spcName,
      spcDescription: spcModel.spcDescription!,
      eveId: spcModel.eventId,
    );

    return Right(savedCategorySponsor);
  }
}
