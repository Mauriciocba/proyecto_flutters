import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_hour_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_hour_metrics_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetLoginsHourMetricsUseCase {
  final LoginsHourMetricsRepository _getLoginsHourMetricsRepository;

  GetLoginsHourMetricsUseCase(
      {required LoginsHourMetricsRepository getLoginsHourMetricsRepository})
      : _getLoginsHourMetricsRepository = getLoginsHourMetricsRepository;

  Future<Either<BaseFailure, List<LoginsHourMetricsModel>>> call(
      DateTime? startDate, DateTime? endDate) async {
    return await _getLoginsHourMetricsRepository.getLoginsHourMetrics(
        startDate, endDate);
  }
}
