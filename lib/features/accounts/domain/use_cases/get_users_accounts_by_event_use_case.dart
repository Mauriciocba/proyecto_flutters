import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';
import 'package:pamphlets_management/features/accounts/domain/repository/account_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class GetUsersAccountsByEventUseCase {
  final AccountRepository _accountRepository;

  GetUsersAccountsByEventUseCase(this._accountRepository);

  Future<Either<BaseFailure, List<Account>>> call({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  }) async {
    final result = await _accountRepository.getAllByEvent(
      eventId: eventId,
      page: page,
      limit: limit,
      search: search,
    );

    return result;
  }
}
