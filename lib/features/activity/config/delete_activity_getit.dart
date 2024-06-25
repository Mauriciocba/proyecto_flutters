import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/activity/delete_activity/data/remote/delete_activity_repository_impl.dart';
import 'package:pamphlets_management/features/activity/delete_activity/domain/repositories/delete_activity_repository.dart';
import 'package:pamphlets_management/features/activity/delete_activity/domain/use_cases/delete_activity_use_case.dart';

void deleteActivityConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteActivityRepository>(() =>
      DeleteActivityRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(DeleteActivityUseCase(
      deleteActivityRepository: GetIt.instance<DeleteActivityRepository>()));
}
