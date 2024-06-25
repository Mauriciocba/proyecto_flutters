import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_events_metrics_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetLoginsEventsMetricsUseCase {
  final LoginsEventsMetricsRepository _getLoginsEventsMetrics;

  GetLoginsEventsMetricsUseCase(
      {required LoginsEventsMetricsRepository getLoginsEventsMetrics})
      : _getLoginsEventsMetrics = getLoginsEventsMetrics;

  Future<Either<BaseFailure, List<LoginsEventsMetricsModel>>> call(
      DateTime? startDate, DateTime? endDate) async {
    return await _getLoginsEventsMetrics.getLoginsEventsMetrics(
        startDate, endDate);
  }
}
