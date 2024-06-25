import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_event_model.dart';

import '../../../core/errors/base_failure.dart';
import '../domain/repositories/payment_events_repository.dart';

class PaymentEventsRepositoryImpl implements PaymentEventsRepository {
  final ApiService _apiService;

  PaymentEventsRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<PaymentEventModel>>> getPaymentEvents(
      DateTime? startDate, DateTime? endDate) async {
    try {
      String url = '/payments/event/metrics';
      if (startDate != null && endDate != null) {
        String startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
        String endDateString =
            '${endDate.year}-${endDate.month}-${endDate.day}';
        url =
            '/payments/event/metrics?startDate=$startDateString&EndDate=$endDateString';
      }
      final response =
          await _apiService.request(method: HttpMethod.get, url: url);

      if (response.body?['data'] == null || response.body == null) {
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
      final List<dynamic> dataList = response.body?['data'];
      final List<PaymentEventModel> paymentEvents =
          dataList.map((data) => PaymentEventModel.fromMap(data)).toList();

      return right(paymentEvents);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
