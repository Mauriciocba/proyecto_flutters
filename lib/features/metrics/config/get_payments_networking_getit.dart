import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_networking_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_networking_use_case.dart';

import '../../../core/network/api_service.dart';
import '../data/payments_networking_repository_impl.dart';

void getPaymentsNetworkingConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<PaymentsNetworkingRepository>(() =>
      PaymentsNetworkingRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(GetPaymentsNetworkingUseCase(
      paymentsNetworkingRepository:
          GetIt.instance<PaymentsNetworkingRepository>()));
}
