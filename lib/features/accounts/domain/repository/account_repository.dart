import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class AccountRepository {
  Future<Either<BaseFailure, List<Account>>> getAllByEvent({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  });
}
