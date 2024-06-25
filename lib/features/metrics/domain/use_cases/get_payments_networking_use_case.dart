import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_networking_model.dart';
import 'package:pamphlets_management/features/metrics/domain/repositories/payments_networking_repository.dart';

import '../../../../core/errors/base_failure.dart';

class GetPaymentsNetworkingUseCase {
  final PaymentsNetworkingRepository _paymentsNetworkingRepository;

  GetPaymentsNetworkingUseCase(
      {required PaymentsNetworkingRepository paymentsNetworkingRepository})
      : _paymentsNetworkingRepository = paymentsNetworkingRepository;

  Future<Either<BaseFailure, List<PaymentNetworkingModel>>> call(
      DateTime? startDate, DateTime? endDate) async {
    return await _paymentsNetworkingRepository.getPaymentNetworking(
        startDate, endDate);
  }
}
