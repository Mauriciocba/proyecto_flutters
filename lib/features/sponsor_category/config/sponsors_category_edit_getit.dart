import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/data/sponsors_category_edit_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_edit_repository.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/edit_sponsors_category_use_case.dart';

void categorySponsorsEditConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<SponsorsCategoryEditRepository>(
      EditSponsorCategoryRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => EditSponsorsCategoryUseCase(GetIt.instance<SponsorsCategoryEditRepository>()));
}
