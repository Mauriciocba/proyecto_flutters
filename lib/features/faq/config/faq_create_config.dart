import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/data/repositories/faq_repository_impl.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/create_faq_use_case.dart';

void faqCreateConfig() async {
  GetIt.instance.registerLazySingleton<FaqRepository>(
      () => FaqRepositoryImpl(apiService: GetIt.instance.get()));

  GetIt.instance.registerFactory(
      () => CreateFaqUseCase(faqRepository: GetIt.instance.get()));
}
