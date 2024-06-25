import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_create/data/stands_create_repository_impl.dart';
import 'package:pamphlets_management/features/stand_create/domain/repositories/stands_repository.dart';
import 'package:pamphlets_management/features/stand_create/domain/use_cases/register_stands_use_case.dart';

void standConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<StandsCreateRepository>(
      StandsCreateRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => RegisterStandsUseCase(GetIt.instance<StandsCreateRepository>()));
}
