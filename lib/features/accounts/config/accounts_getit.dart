import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/accounts/data/repository/account_repository_impl.dart';
import 'package:pamphlets_management/features/accounts/domain/repository/account_repository.dart';
import 'package:pamphlets_management/features/accounts/domain/use_cases/get_users_accounts_by_event_use_case.dart';

void accountsConfig() async {
  GetIt.instance.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      apiService: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => GetUsersAccountsByEventUseCase(
      GetIt.instance.get(),
    ),
  );
}
