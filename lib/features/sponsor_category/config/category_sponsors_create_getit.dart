
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/data/sponsor_category_create_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_create_repository.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/register_sponsors_category_use_cases.dart';

void categorySponsorsCreateConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<SponsorCategoryCreateRepository>(
      SponsorCategoryCreateRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => RegisterSponsorsCategoryUseCase(GetIt.instance<SponsorCategoryCreateRepository>()));
}
