import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/accounts/data/models/account_response.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';
import 'package:pamphlets_management/features/accounts/domain/repository/account_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class AccountRepositoryImpl implements AccountRepository {
  final ApiService _apiService;

  AccountRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, List<Account>>> getAllByEvent({
    required int eventId,
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      var stringQuery = "&search=";
      if (search != null) {
        stringQuery += search;
      }

      final response = await _apiService.request(
        method: HttpMethod.get,
        url:
            '/user-company/user-event/$eventId?page=$page&limit=$limit$stringQuery',
      );

      if (response.body == null || response.body?['data'] == null) {
        return left(
            BaseFailure(message: 'No se obtuvo respuesta del servidor'));
      }

      if (response.resultType == ResultType.error) {
        return left(BaseFailure(message: response.body?['message']));
      }

      if (response.resultType == ResultType.failure) {
        return left(BaseFailure(message: response.body?['message']));
      }

      if (response.body?['statusCode'] == HttpStatus.noContent) {
        return const Right([]);
      }

      final accountsResponse =
          accountResponseFromJson(jsonEncode(response.body?['data']));

      final accounts = accountsResponse
          .map((e) => Account(
                accountId: e.usrId,
                mail: e.email,
                name: e.name,
                image: e.photo,
                companyName: e.company,
              ))
          .toList();

      return Right(accounts);
    } catch (e) {
      return left(BaseFailure(message: 'Hubo un fallo interno'));
    }
  }
}
