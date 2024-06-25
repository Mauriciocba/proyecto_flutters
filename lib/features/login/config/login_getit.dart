import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/core/network/dio_config.dart';
import 'package:pamphlets_management/features/login/data/repositories/credential_repository_impl.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage.dart';
import 'package:pamphlets_management/features/login/data/storage/credential_local_storage_impl.dart';
import 'package:pamphlets_management/features/login/domain/repositories/credential_repository.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_use_case.dart';

void loginConfigure() {
  GetIt.instance.registerSingleton<CredentialLocalStorage>(
    CredentialLocalStorageImpl(),
  );

  GetIt.instance.registerSingleton(ApiService(dio));

  GetIt.instance.registerSingleton<CredentialRepository>(
    CredentialRepositoryImpl(
      GetIt.instance.get<ApiService>(),
      GetIt.instance.get<CredentialLocalStorage>(),
    ),
  );

  GetIt.instance.registerFactory<LoginUseCase>(
    () => LoginUseCase(
      credentialRepository: GetIt.instance.get<CredentialRepository>(),
    ),
  );
}
