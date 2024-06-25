import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/metrics/data/activity_metrics_repository_impl.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/activity_metrics_repository.dart';
import 'package:pamphlets_management/features/metrics/domain/use_cases/get_activity_metrics_use_case.dart';

void getActivityMetricsConfigure() async {
//Repositories
  GetIt.instance.registerLazySingleton<ActivityMetricsRepository>(
      () => ActivityMetricsRepositoryImpl(apiService: GetIt.instance.get()));

//Use cases
  GetIt.instance
      .registerFactory(() => GetActivityMetricsUseCase(GetIt.instance.get()));
}