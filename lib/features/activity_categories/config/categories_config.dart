import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/data/repositories/categories_repository_impl.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/categories_repository.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/get_categories_use_case.dart';

void categoriesConfig() {
//Repositories
  GetIt.instance.registerLazySingleton<CategoriesRepository>(() =>
      CategoriesRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(GetCategoriesUseCase(
      categoriesRepository: GetIt.instance.get<CategoriesRepository>()));
}
