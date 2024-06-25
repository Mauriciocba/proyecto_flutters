import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/sign_up/data/repositories/user_repository_impl.dart';
import 'package:pamphlets_management/features/sign_up/domain/repositories/user_repository.dart';
import 'package:pamphlets_management/features/sign_up/domain/use_cases/sign_up_use_cases.dart';

void signUpConfigure() {
  GetIt.instance.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      apiService: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => SignUpUseCase(
      userRepository: GetIt.instance.get<UserRepository>(),
    ),
  );
}
