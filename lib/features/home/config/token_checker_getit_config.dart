import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/home/data/local/token_checker_repository.dart';
import 'package:pamphlets_management/features/home/data/local/token_checker_repository_impl.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';

void tokenCheckerConfig() {
//Repositories
  GetIt.instance.registerLazySingleton<TokenCheckerRepository>(
      () => TokenCheckerRepositoryImpl());

//Use cases
  GetIt.instance.registerSingleton(TokenCheckerUseCase(
      tokenCheckerRepository: GetIt.instance<TokenCheckerRepository>()));
}
