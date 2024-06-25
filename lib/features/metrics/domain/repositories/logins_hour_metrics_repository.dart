import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_hour_metrics_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class LoginsHourMetricsRepository {
  Future<Either<BaseFailure, List<LoginsHourMetricsModel>>>
      getLoginsHourMetrics(DateTime? startDate, DateTime? endDate);
}
