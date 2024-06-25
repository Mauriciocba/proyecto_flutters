import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/event_configuration/data/event_configuration_repository_impl.dart';

import 'package:pamphlets_management/features/event_configuration/domain/repositories/event_configuration_repository.dart';
import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_edit_use_case.dart';

import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_use_case.dart';


void eventConfigurationGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<EventConfigurationRepository>(() =>
      EventConfigurationRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(EditConfigurationUseCase(
      GetIt.instance<EventConfigurationRepository>()));     

//Use cases
  GetIt.instance.registerSingleton(GetEventConfigurationUseCase(
      GetIt.instance<EventConfigurationRepository>()));
}
