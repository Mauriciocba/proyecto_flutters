import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event/data/events_repository_impl.dart';

import '../domain/repositories/event_all_repository.dart';
import '../domain/use_cases/get_events_all_use_case.dart';

void eventAllConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<EventAllRepository>(
      () => EventRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      GetEventAllUseCase(GetIt.instance<EventAllRepository>()));
}
