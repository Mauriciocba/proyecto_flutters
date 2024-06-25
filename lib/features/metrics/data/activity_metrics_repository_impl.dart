import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/data/models/activity_metric_response.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/activity_metrics_repository.dart';

import '../../../core/errors/base_failure.dart';
import '../domain/entities/activity_metric.dart';

class ActivityMetricsRepositoryImpl implements ActivityMetricsRepository {
  final ApiService _apiService;

  ActivityMetricsRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<ActivityMetric>>> getActivityMetrics(
      int eventId, DateTime? startDate, DateTime? endDate) async {
    try {
      String url = '/schedule/metrics/$eventId';
      if (startDate != null && endDate != null) {
        String startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
        String endDateString =
            '${endDate.year}-${endDate.month}-${endDate.day}';
        url =
            '/schedule/metrics/$eventId?startDate=$startDateString&endDate=$endDateString';
      }

      final response =
          await _apiService.request(method: HttpMethod.get, url: url);

      if (response.body == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener los datos solicitados'));
      }

      if (response.resultType == ResultType.error) {
        return left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }
      final responseData = response.body;
      final List<dynamic>? data = responseData?['data'];

      final List<ActivityMetric>? activityMetrics = data?.map((item) {
        final activityMetricResponse = ActivityMetricResponse.fromMap(item);
        return ActivityMetric(
          actId: activityMetricResponse.actId,
          actName: activityMetricResponse.actName,
          activityLogs: activityMetricResponse.activityLogs,
        );
      }).toList();

      return right(activityMetrics ?? []);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
