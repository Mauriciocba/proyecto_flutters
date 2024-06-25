import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/forgot_password/data/verify_code_password_repository_impl.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/verify_code_password_repository.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/verify_code_password_use_case.dart';

void verifyCodePasswordConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<VerifyCodePasswordRepository>(
      VerifyCodePasswordRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => VerifyCodePasswordUseCase(GetIt.instance<VerifyCodePasswordRepository>()));
}