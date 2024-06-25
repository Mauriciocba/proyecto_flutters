import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsors_info/data/sponsors_info_repository_impl.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/repositories/sponsors_info_repository.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/use_cases/get_sponsors_use_cases.dart';

void sponsorsInfoConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<SponsorsInfoRepository>(() =>
      SponsorsInfoRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetSponsorsInfoUseCase(GetIt.instance<SponsorsInfoRepository>()));
}