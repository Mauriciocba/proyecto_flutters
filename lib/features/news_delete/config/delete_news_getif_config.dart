import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';

import '../data/delete_news_repository_impl.dart';
import '../domain/repositories/delete_news_repository.dart';
import '../domain/use_case/delete_news_use_case.dart';


void deleteNewsGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteNewsRepository>(
      () => DeleteNewsRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      DeleteNewsUseCase(GetIt.instance<DeleteNewsRepository>()));
}