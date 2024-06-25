import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_networking_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class PaymentsNetworkingRepository {
  Future<Either<BaseFailure, List<PaymentNetworkingModel>>>
      getPaymentNetworking(DateTime? startDate, DateTime? endDate);
}
