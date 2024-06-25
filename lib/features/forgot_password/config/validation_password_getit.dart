import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/forgot_password/data/validation_password_repository_impl.dart';
import 'package:pamphlets_management/features/forgot_password/domain/repositories/validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/register_validation_password.dart';

void validationPasswordConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<ValidationPasswordRepository>(
      ValidationPasswordRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
      () => RegisterValidationPassword(GetIt.instance<ValidationPasswordRepository>()));
}
