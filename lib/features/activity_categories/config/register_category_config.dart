import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/data/repositories/register_category_repository_impl.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/register_category_repository.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/register_new_category_use_case.dart';

void registerCategoryConfig() {
//Repositories
  GetIt.instance.registerLazySingleton<RegisterCategoryRepository>(() =>
      RegisterCategoryRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(RegisterNewCategoryUseCase(
      categoryRepository: GetIt.instance.get<RegisterCategoryRepository>()));
}
