import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/validation/data/remote/verify_code_repository_impl.dart';
import 'package:pamphlets_management/features/validation/domain/repositories/verify_code_repository.dart';
import 'package:pamphlets_management/features/validation/domain/use_cases/verify_code_use_case.dart';

import '../../../core/network/api_service.dart';

void verifyCodeConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<VerifyCodeRepository>(() =>
      VerifyCodeRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      GetVerifyCodeUseCase(GetIt.instance<VerifyCodeRepository>()));
}
