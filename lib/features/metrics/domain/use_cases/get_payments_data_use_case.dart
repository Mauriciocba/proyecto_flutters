import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_date_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_data_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetPaymentsDataUseCase {
  final PaymentsDataRepository _getPaymentDataRepository;

  GetPaymentsDataUseCase(
      {required PaymentsDataRepository getPaymentDataRepository})
      : _getPaymentDataRepository = getPaymentDataRepository;

  Future<Either<BaseFailure, List<PaymentDateModel>>> call(
      DateTime? startDate, DateTime? endDate) async {
    return await _getPaymentDataRepository.getPaymentData(startDate, endDate);
  }
}
