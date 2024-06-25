import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/location/data/services/address_suggestions_service_impl.dart';
import 'package:pamphlets_management/features/location/data/services/location_permission_service_impl.dart';
import 'package:pamphlets_management/features/location/data/services/position_service_impl.dart';
import 'package:pamphlets_management/features/location/domain/services/address_suggestion_service.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/location/domain/services/location_permission_service.dart';
import 'package:pamphlets_management/features/location/domain/services/position_services.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/get_address_suggestions_use_case.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/get_user_position_use_case.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/request_permission_use_case.dart';

void getAddressSuggestionsConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<AddressSuggestionsService>(() =>
      AddressSuggestionsImpl(apiService: GetIt.instance.get<ApiService>()));
  GetIt.instance.registerLazySingleton<LocationPermissionService>(
      () => LocationPermissionServiceImpl());
  GetIt.instance
      .registerLazySingleton<PositionService>(() => PositionServiceImpl());

//Use cases
  GetIt.instance.registerSingleton(
      AddressSuggestionsUseCase(GetIt.instance<AddressSuggestionsService>()));
  GetIt.instance.registerSingleton(
      RequestPermissionUseCase(GetIt.instance<LocationPermissionService>()));
  GetIt.instance
      .registerSingleton(GetUserPositionUseCase(GetIt.instance.get()));
}
