import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/data/repositories/faq_image_save_repository_imp.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_save_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/save_faq_image_use_case.dart';

void faqImageConfig() {
  GetIt.instance.registerLazySingleton<FaqImageSaveRepository>(
      () => FaqImageSaveRepositoryImpl(GetIt.instance.get()));

  GetIt.instance.registerFactory(
    () => SaveFaqImageUseCase(GetIt.instance.get()),
  );
}
