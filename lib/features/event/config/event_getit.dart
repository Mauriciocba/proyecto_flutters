import 'package:get_it/get_it.dart';

import '../../../core/network/api_service.dart';
import '../data/remote/create_event_repository_impl.dart';
import '../domain/repositories/create_event_repository.dart';
import '../domain/use_cases/create_event_use_case.dart';

void eventConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<CreateEventRepository>(
      () => CreateEventRepositoryImpl(GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      CreateEventUseCase(GetIt.instance<CreateEventRepository>()));
}
