import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/downloads/common/file_server.dart';
import 'package:pamphlets_management/features/downloads/domain/repository/download_repository.dart';

import '../../../../core/errors/base_failure.dart';

final class DownloadRepositoryImpl implements DownloadRepository {
  final ApiService _apiService;
  DownloadRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<BaseFailure, String>> downloadArchiveEvents() async {
    final response = await _apiService.request(
      method: HttpMethod.get,
      url: '/events/export-excel',
    );
    if (response.body == null) {
      return left(BaseFailure(message: 'No se obtuvo respuesta del servidor'));
    }

    if (response.resultType == ResultType.error) {
      return left(BaseFailure(message: response.body?['message']));
    }

    if (response.resultType == ResultType.failure) {
      return left(BaseFailure(message: response.body?['message']));
    }

    final Uint8List bytes = response.body!['excel'];

    await downloadFile(bytes, '', 'eventos');
    return const Right('');
  }

  @override
  Future<Either<BaseFailure, String>> downloadArchiveActivities(
      int? eventId, String eventName) async {
    final response = await _apiService.request(
      method: HttpMethod.get,
      url: '/activity/export-excel/$eventId',
    );
    return responseHandler('No existen actividades para evento $eventName',
        eventName, response, 'actividades');
  }

  @override
  Future<Either<BaseFailure, String>> downloadArchiveSpeakers(
      int? eventId, String eventName) async {
    final response = await _apiService.request(
      method: HttpMethod.get,
      url: '/speakers/export-excel/$eventId',
    );
    return responseHandler('No existen speakers para evento $eventName',
        eventName, response, 'speakers');
  }

  @override
  Future<Either<BaseFailure, String>> downloadUsers(
      int? eventId, String eventName) async {
    final response = await _apiService.request(
      method: HttpMethod.get,
      url: '/user-company/export-excel/$eventId',
    );
    return responseHandler('No existen usuarios para evento $eventName',
        eventName, response, 'usuarios');
  }

  Future<Either<BaseFailure, String>> responseHandler(String errorMessage,
      String eventName, ApiResult response, String type) async {
    if (response.body == null || response.resultType == ResultType.error) {
      return left(BaseFailure(message: 'No se obtuvo respuesta del servidor'));
    }

    if (response.resultType == ResultType.failure) {
      return left(BaseFailure(message: errorMessage));
    }

    final Uint8List bytes = response.body!['excel'];

    await downloadFile(bytes, eventName, type);
    return const Right('');
  }
}
