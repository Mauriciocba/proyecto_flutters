import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/core/router/app_router.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';

import 'dio_config.dart';

final class AuthInterceptor implements Interceptor {
  final CredentialLocalStorage _credentialLocalStorage;
  final AppRouter _appRouter;

  AuthInterceptor({
    required CredentialLocalStorage credentialLocalStorage,
    required AppRouter appRouter,
  })  : _credentialLocalStorage = credentialLocalStorage,
        _appRouter = appRouter;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('\n🙏🏻 REQUEST[${options.method}] => PATH: ${options.path}');
    try {
      if (_isProtectedPath(options.path)) {
        final token = await _getToken();
        options.headers['authorization'] = "Bearer $token";
      }
      return handler.next(options);
    } catch (_) {
      _cleanCredentialsAndRedirectToLogin();
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '📩 RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        '😡 ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, BODY: ${err.response}');

    if (err.requestOptions.path == '/refresh-tokens' &&
        err.response?.statusCode == HttpStatus.unauthorized) {
      debugPrint('No se pudo obtener el refresh token');
      _cleanCredentialsAndRedirectToLogin();
      return;
    }

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await _refreshToken();
      final response = await dio.fetch(err.requestOptions);
      return handler.resolve(response);
    }

    return handler.next(err);
  }

  Future<String> _getToken() async {
    final credential = await _credentialLocalStorage.read();
    return credential.token;
  }

  bool _isProtectedPath(String path) {
    if (path.contains('/auth/login/admin') ||
        path.contains('/auth/signup') ||
        path.contains('/email/validate-email') ||
        path.contains('/forgot-password/sending-code') ||
        path.contains('/auth/google/login')) {
      return false;
    }
    return true;
  }

  Future<void> _refreshToken() async {
    try {
      final credentials = await _credentialLocalStorage.read();

      final response = await dio.post(
        "/refresh-tokens",
        data: {'refreshToken': credentials.refreshToken},
      );

      final newCredential = Credential(
        token: response.data['accessToken'],
        refreshToken: response.data['newRefreshToken'],
      );

      _credentialLocalStorage.save(newCredential);
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        debugPrint("Cerrar sesión por sesión no autorizada");
        _cleanCredentialsAndRedirectToLogin();
      }
    }
  }

  void _cleanCredentialsAndRedirectToLogin() {
    _credentialLocalStorage.clear();
    _appRouter.go("/");
  }
}
