import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/data/repositories/delete_category_repository_impl.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/delete_category_repository.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/delete_category_use_case.dart';

void deleteCategoryConfig() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteCategoryRepository>(
      () => DeleteCategoryRepositoryImpl(GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      DeleteCategoryUseCase(GetIt.instance.get<DeleteCategoryRepository>()));
}
