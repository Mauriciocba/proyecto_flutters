import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/metrics/data/payments_data_repository_impl.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_data_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payments_data_use_case.dart';

import '../../../core/network/api_service.dart';

void getPaymentsDataConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<PaymentsDataRepository>(() =>
      PaymentDataRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(GetPaymentsDataUseCase(
      getPaymentDataRepository: GetIt.instance<PaymentsDataRepository>()));
}
