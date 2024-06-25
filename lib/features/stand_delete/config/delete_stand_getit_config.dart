import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/stand_delete/data/delete_stand_repository_impl.dart';
import 'package:pamphlets_management/features/stand_delete/domain/repositories/delete_stand_repository.dart';
import 'package:pamphlets_management/features/stand_delete/domain/use_cases/delete_stand_use_case.dart';

void deleteStandGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteStandRepository>(
      () => DeleteStandRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      DeleteStandUseCase(GetIt.instance<DeleteStandRepository>()));
}