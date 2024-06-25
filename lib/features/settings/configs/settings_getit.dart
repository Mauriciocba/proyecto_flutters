import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/settings/data/repositories/password_updater_repository_impl.dart';
import 'package:pamphlets_management/features/settings/domain/repositories/password_updater_repository.dart';
import 'package:pamphlets_management/features/settings/domain/use_cases/update_password_use_case.dart';

void settingsConfigure() {
  GetIt.instance.registerLazySingleton<PasswordUpdaterRepository>(
      () => PasswordUpdaterRepositoryImpl(apiService: GetIt.instance.get()));

  GetIt.instance.registerSingleton(
      UpdatePasswordUseCase(passwordUpdaterRepository: GetIt.instance.get()));
}
