import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/data/repositories/faq_delete_repository_impl.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_delete_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/delete_faq_use_case.dart';

void faqDeleteConfig() async {
  GetIt.instance.registerLazySingleton<FaqDeleteRepository>(
      () => FaqDeleteRepositoryImpl(GetIt.instance.get()));

  GetIt.instance.registerFactory(
      () => DeleteFaqUseCase(faqDeleteRepository: GetIt.instance.get()));
}
