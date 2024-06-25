import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/features/faq/data/repositories/get_all_faq_repository_impl.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_get_all_repository.dart';

import 'package:pamphlets_management/features/faq/domain/use_case/get_all_faq_use_case.dart';

void faqsConfig() async {
  GetIt.instance.registerLazySingleton<FaqGetAllRepository>(
    () => FaqGetAllRepositoryImpl(apiService: GetIt.instance.get()),
  );

  GetIt.instance.registerFactory(() => GetAllFaqUseCase(GetIt.instance.get()));
}
