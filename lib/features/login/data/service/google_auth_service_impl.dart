import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:pamphlets_management/core/environment/environment.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/login/domain/entities/credential.dart';
import 'package:pamphlets_management/features/login/domain/service/auth_service.dart';

import '../../../../core/errors/base_failure.dart';

final class GoogleAuthServiceImpl implements AuthService {
  final ApiService _apiService;

  GoogleAuthServiceImpl(this._apiService);

  @override
  Future<String> authenticate() async {
    //* requestAccessCredentials -> obtiene el access token
    //*  requestAuthorizationCode -> obtiene el code de autorización
    try {
      final authorizationCodeResponse = await requestAuthorizationCode(
        clientId: Environment.googleClientId,
        scopes: [
          'https://www.googleapis.com/auth/youtube.readonly',
          'https://www.googleapis.com/auth/youtube.force-ssl',
          'https://www.googleapis.com/auth/youtube.upload',
          'https://www.googleapis.com/auth/youtube',
          'https://www.googleapis.com/auth/userinfo.email',
          'https://www.googleapis.com/auth/userinfo.profile',
          'https://www.googleapis.com/auth/calendar.readonly',
          'https://www.googleapis.com/auth/calendar.events'
        ],
      );

      return authorizationCodeResponse.code;
    } catch (e) {
      debugPrint("Error al autenticar: $e");
      throw BaseFailure(
          message: "No se pudo autenticar. Inténtalo de nuevo más tarde.");
    }
  }

  @override
  Future<Either<BaseFailure, Credential>> login(
      String authorizationCodeResponse) async {
    try {
      final response = await _apiService.request(
        method: HttpMethod.get,
        url: '/auth/google/login?code=$authorizationCodeResponse',
      );
      if (response.resultType == ResultType.failure) {
        return Left(BaseFailure(
            message: response.body?["message"] ?? 'Error en la solicitud.'));
      }

      if (response.resultType == ResultType.error) {
        return Left(BaseFailure(
            message:
                response.body?["message"] ?? 'Error interno del servidor.'));
      }

      if (response.body?['statusCode'] == HttpStatus.unauthorized) {
        return Left(BaseFailure(message: "Cuenta no validada"));
      }

      final credential = Credential(
        token: response.body?['access_token'],
        refreshToken: response.body?["refreshToken"],
      );

      return Right(credential);
    } catch (e) {
      debugPrint("Fallo al intentar autenticarse por google: $e");
      return Left(BaseFailure(
          message:
              "Error al intentar autenticarse. Por favor, inténtalo de nuevo."));
    }
  }
}
