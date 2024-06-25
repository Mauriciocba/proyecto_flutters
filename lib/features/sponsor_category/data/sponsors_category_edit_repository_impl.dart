import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_register_form.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_edit_repository.dart';

import '../../../core/errors/base_failure.dart';

final class EditSponsorCategoryRepositoryImpl
    implements SponsorsCategoryEditRepository {
  final ApiService _apiService;

  EditSponsorCategoryRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, SponsorsCategoryModel>> loadSponsorsCategory(
      {required int categoryId,
      required SponsorsCategoryRegistrationForm newCategoryData}) async {
    try {
      final result = await _apiService.request(
        method: HttpMethod.patch,
        url: '/sponsors-categories/update/id/$categoryId',
        body: {
          "spc_name": newCategoryData.spcName,
          "spc_description": newCategoryData.spcDescription,
        },
      );

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: 'Ruta inexistente.'));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(message: 'Hubo un error interno.'));
      }

      final updatedCategory = SponsorsCategoryModel(
          spcId: categoryId,
          spcName: newCategoryData.spcName,
          spcDescription: newCategoryData.spcDescription!,
          eveId: null);

      return Right(updatedCategory);
    } catch (e) {
      return Left(BaseFailure(message: '$e'));
    }
  }
}
