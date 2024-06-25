import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/metrics/data/payment_events_respository_impl.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payment_events_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_payment_events_use_case.dart';

import '../../../core/network/api_service.dart';

void getPaymentEventsConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<PaymentEventsRepository>(() =>
      PaymentEventsRepositoryImpl(
          apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(GetPaymentEventsUseCase(
      getPaymentEventsRepository: GetIt.instance<PaymentEventsRepository>()));
}
