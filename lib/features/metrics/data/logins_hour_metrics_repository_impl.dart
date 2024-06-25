import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_hour_metrics_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/logins_hour_metrics_repository.dart';

import '../../../core/errors/base_failure.dart';

class LoginsHourMetricsRepositoryImpl implements LoginsHourMetricsRepository {
  final ApiService _apiService;

  LoginsHourMetricsRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<LoginsHourMetricsModel>>>
      getLoginsHourMetrics(DateTime? startDate, DateTime? endDate) async {
    try {
      String url = '/user-tracking/hour';
      if (startDate != null && endDate != null) {
        String startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
        String endDateString =
            '${endDate.year}-${endDate.month}-${endDate.day}';
        url =
            '/user-tracking/hour?startDate=$startDateString&EndDate=$endDateString';
      }
      final response =
          await _apiService.request(method: HttpMethod.get, url: url);

      if (response.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se pudo obtener datos del servidor'));
      }

      if (response.resultType == ResultType.error) {
        return left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }

      if (response.resultType == ResultType.failure) {
        return left(
            BaseFailure(message: 'Hubo una falla en la obtención de datos'));
      }
      if (response.resultType == ResultType.success) {
        List<dynamic> data = response.body?['data'];
        List<LoginsHourMetricsModel> loginsHourMetricsList =
            data.map((item) => LoginsHourMetricsModel.fromMap(item)).toList();
        return right(loginsHourMetricsList);
      } else {
        return left(BaseFailure(
            message: 'No se pudo realizar la solicitud al servidor'));
      }
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
