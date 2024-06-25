import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/metrics/data/logins_events_metrics_repository_impl.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_events_metrics_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_logins_events_metrics_use_case.dart';

import '../../../core/network/api_service.dart';

void getLoginsEventsMetricsConfigure() {
//Repositories
  GetIt.instance.registerLazySingleton<LoginsEventsMetricsRepository>(() =>
      LoginsEventsMetricsImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(GetLoginsEventsMetricsUseCase(
      getLoginsEventsMetrics: GetIt.instance<LoginsEventsMetricsRepository>()));
}
