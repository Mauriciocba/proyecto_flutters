import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/data/sponsors_category_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_repository.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/get_sponsors_category_use_case.dart';


void categorySponsorsConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<SponsorsCategoryRepository>(() =>
      SponsorsCategoryRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetSponsorsCategoryUseCase(GetIt.instance<SponsorsCategoryRepository>()));
}
