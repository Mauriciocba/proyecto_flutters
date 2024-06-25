import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_date_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_data_repository.dart';

import '../../../core/errors/base_failure.dart';

class PaymentDataRepositoryImpl implements PaymentsDataRepository {
  final ApiService _apiService;

  PaymentDataRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<PaymentDateModel>>> getPaymentData(
      DateTime? startDate, DateTime? endDate) async {
    try {
      String url = '/payments/metrics';
      if (startDate != null && endDate != null) {
        String startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
        String endDateString =
            '${endDate.year}-${endDate.month}-${endDate.day}';
        url =
            '/payments/metrics?startDate=$startDateString&EndDate=$endDateString';
      }

      final response =
          await _apiService.request(method: HttpMethod.get, url: url);

      if (response.body == null || response.body?['data'] == null) {
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
      final List<PaymentDateModel> paymentDateEvents =
          dataList.map((data) => PaymentDateModel.fromMap(data)).toList();

      return right(paymentDateEvents);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
