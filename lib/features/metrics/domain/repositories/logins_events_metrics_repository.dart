import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class LoginsEventsMetricsRepository {
  Future<Either<BaseFailure, List<LoginsEventsMetricsModel>>>
      getLoginsEventsMetrics(DateTime? startDate, DateTime? endDate);
}
