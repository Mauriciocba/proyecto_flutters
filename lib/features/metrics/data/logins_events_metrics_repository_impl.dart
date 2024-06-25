import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_events_metrics_repository.dart';

import '../../../core/errors/base_failure.dart';

class LoginsEventsMetricsImpl implements LoginsEventsMetricsRepository {
  final ApiService _apiService;

  LoginsEventsMetricsImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<LoginsEventsMetricsModel>>>
      getLoginsEventsMetrics(DateTime? startDate, DateTime? endDate) async {
    try {
      String url = '/user-tracking/event';
      if (startDate != null && endDate != null) {
        String startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
        String endDateString =
            '${endDate.year}-${endDate.month}-${endDate.day}';
        url =
            '/user-tracking/event?startDate=$startDateString&EndDate=$endDateString';
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
      final List<dynamic> eventDataList = response.body!['data'] ?? [];

      final List<LoginsEventsMetricsModel> metricsList = eventDataList
          .map((eventData) => LoginsEventsMetricsModel.fromMap(eventData))
          .toList();
      return right(metricsList);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
