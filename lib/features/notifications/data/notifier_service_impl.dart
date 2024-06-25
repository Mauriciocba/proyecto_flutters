import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/notifications/domain/entities/notification.dart';
import 'package:pamphlets_management/features/notifications/domain/service/notifier_service.dart';

import '../../../core/errors/base_failure.dart';

final class NotifierServiceImpl implements NotifierService {
  final ApiService _apiService;

  NotifierServiceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, String>> send({
    required Notification notification,
  }) async {
    final response = await _apiService.request(
        method: HttpMethod.post,
        url: '/notifications/send/${notification.senderEventId}',
        body: {
          'title': notification.title,
          'body': notification.title,
        });

    if (response.resultType == ResultType.error) {
      return Left(BaseFailure(message: "Sucedió un error intente nuevamente"));
    }

    if (response.resultType == ResultType.failure) {
      return Left(BaseFailure(message: response.body!['message']));
    }

    if (response.body?['status'] != HttpStatus.ok) {
      return Left(BaseFailure(message: response.body!['message']));
    }

    return Right(response.body?['message'] ?? "Enviado");
  }
}
