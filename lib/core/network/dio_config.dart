import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../environment/environment.dart';
import 'auth_interceptor.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: Environment.baseUrl,
    contentType: Headers.jsonContentType,
    headers: <String, String>{'Accept': 'application/json'},
  ),
)..interceptors.add(
    AuthInterceptor(
      appRouter: GetIt.instance.get(),
      credentialLocalStorage: GetIt.instance.get(),
    ),
  );
