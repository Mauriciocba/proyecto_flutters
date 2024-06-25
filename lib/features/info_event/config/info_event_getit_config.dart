import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/info_event/domain/repositories/info_event_repository.dart';

import '../data/repositories/info_event_repository_impl.dart';
import '../domain/use_cases/info_event_use_case.dart';


void getItInfoEvent() {
//Repositories
  GetIt.instance.registerLazySingleton<InfoEventRepository>(
      () => InfoEnventRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      GetInfoEventUseCase(GetIt.instance<InfoEventRepository>()));
}
