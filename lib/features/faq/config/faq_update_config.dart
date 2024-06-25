import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/data/repositories/faq_update_repository_impl.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_update_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/update_faq_use_case.dart';

void faqUpdateConfig() {
  GetIt.instance.registerLazySingleton<FaqUpdateRepository>(
    () => FaqUpdateRepositoryImple(GetIt.instance.get()),
  );

  GetIt.instance.registerFactory(
    () => UpdateFaqUseCase(
      GetIt.instance.get(),
      GetIt.instance.get(),
      GetIt.instance.get(),
    ),
  );
}
