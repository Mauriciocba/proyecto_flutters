import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity_categories/data/repositories/update_category_repository_impl.dart';
import 'package:pamphlets_management/features/activity_categories/domain/repositories/update_category_repository.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/update_category_use_case.dart';

void updateCategoryConfig() {
//Repositories
  GetIt.instance.registerLazySingleton<UpdateCategoryRepository>(
      () => UpdateCategoryRepositoryImpl(GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(UpdateCategoryUseCase(GetIt.instance.get()));
}
