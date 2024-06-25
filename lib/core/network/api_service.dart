import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'api_result.dart';

enum HttpMethod { get, post, put, patch, delete }

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<ApiResult> request({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final result = await _dio.request(
        url,
        data: body,
        options: Options(
            method: method.name.toUpperCase(),
            responseType: url.contains('export-excel')
                ? ResponseType.bytes
                : ResponseType.json),
      );

      return ApiResult.success(
        body: result.headers['content-type']!.contains(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            ? {'excel': result.data}
            : result.data,
        statusCode: result.statusCode,
      );
    } on DioException catch (e) {
      if (e.response == null) {
        return ApiResult.failure(body: {
          'message': 'No se pudo establecer conexión con el servidor'
        });
      }

      return ApiResult.failure(
        body: e.response?.data is Uint8List
            ? {'message': json.decode(utf8.decode(e.response?.data))}
            : e.response?.data,
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResult.error();
    }
  }
}
