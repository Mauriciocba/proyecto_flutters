import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/log_out/data/local/token_deleter.dart';
import 'package:pamphlets_management/features/log_out/data/local/token_deleter_impl.dart';
import 'package:pamphlets_management/features/log_out/data/remote/log_out_repository_impl.dart';
import 'package:pamphlets_management/features/log_out/domain/repositories/log_out_repository.dart';
import 'package:pamphlets_management/features/log_out/domain/use_cases/log_out_use_case.dart';

import '../../../core/network/api_service.dart';

void logOutConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<LogOutRepository>(() =>
      LogOutRepositoryImpl(GetIt.instance.get<ApiService>(),
          GetIt.instance.get<TokenDeleter>()));

  GetIt.instance.registerLazySingleton<TokenDeleter>(() => TokenDeleterImpl());

//Use cases
  GetIt.instance.registerFactory(() =>
      LogOutUseCase(logOutRepository: GetIt.instance<LogOutRepository>()));
}
