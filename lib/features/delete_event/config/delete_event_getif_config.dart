import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/delete_event/data/remote/delete_event_repository_impl.dart';
import 'package:pamphlets_management/features/delete_event/domain/repositories/delete_event_repository.dart';
import 'package:pamphlets_management/features/delete_event/domain/use_cases/delete_event_use_case.dart';


void deleteEventGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteEventRepository>(
      () => DeleteEventRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      GetDeleteEventUseCase(GetIt.instance<DeleteEventRepository>()));
}