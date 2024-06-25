import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_category/data/sponsors_category_delete_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/repositories/sponsors_category_delete_repository.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/use_cases/delete_sponsors_category_use_case.dart';

void categorySponsorsDeleteGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<SponsorsCategoryDeleteRepository>(() =>
      SponsorsCategoryDeleteRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(DeleteSponsorsCategoryUseCase(
      GetIt.instance<SponsorsCategoryDeleteRepository>()));
}
