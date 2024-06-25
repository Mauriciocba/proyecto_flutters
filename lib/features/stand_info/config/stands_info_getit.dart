import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_info/data/stands_info_repository_impl.dart';
import 'package:pamphlets_management/features/stand_info/domain/repositories/stands_info_repository.dart';
import 'package:pamphlets_management/features/stand_info/domain/use_cases/get_stands_info.dart';

void standsInfoConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<StandsInfoRepository>(() =>
      StandsInfoRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetStandsInfoUseCase(GetIt.instance<StandsInfoRepository>()));
}