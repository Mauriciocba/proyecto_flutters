import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_date_model.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class PaymentsDataRepository {
  Future<Either<BaseFailure, List<PaymentDateModel>>> getPaymentData(
      DateTime? startDate, DateTime? endDate);
}
