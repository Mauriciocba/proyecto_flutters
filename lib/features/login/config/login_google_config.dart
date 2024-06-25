import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/login/data/service/google_auth_service_impl.dart';
import 'package:pamphlets_management/features/login/domain/repositories/credential_repository.dart';
import 'package:pamphlets_management/features/login/domain/service/auth_service.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_by_google_use_case.dart';

void loginGoogleConfig() {
  GetIt.instance.registerLazySingleton<AuthService>(
    () => GoogleAuthServiceImpl(
      GetIt.instance.get<ApiService>(),
    ),
  );

  GetIt.instance.registerSingleton(
    LoginByGoogleUseCase(
      externalAuthService: GetIt.instance.get<AuthService>(),
      credentialRepository: GetIt.instance.get<CredentialRepository>(),
    ),
  );
}
