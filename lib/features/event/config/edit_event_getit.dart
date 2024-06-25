import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/event/data/remote/edit_event_repository_impl.dart';
import 'package:pamphlets_management/features/event/domain/repositories/edit_event_repository.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/edit_event_use_case.dart';

import '../../../core/network/api_service.dart';

void editEventConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<EditEventRepository>(() =>
      EditEventRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      EditEventUseCase(GetIt.instance<EditEventRepository>()));
}
