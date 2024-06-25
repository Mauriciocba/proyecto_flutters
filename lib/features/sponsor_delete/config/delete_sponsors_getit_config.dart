import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/sponsor_delete/data/delete_sponsors_repository_impl.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/repositories/delete_sponsors_repository.dart';
import 'package:pamphlets_management/features/sponsor_delete/domain/use_cases/delete_sponsors_use_case.dart';

void deleteSponsorsGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteSponsorsRepository>(
      () => DeleteSponsorsRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      DeleteSponsorsUseCase(GetIt.instance<DeleteSponsorsRepository>()));
}