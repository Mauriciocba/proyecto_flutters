import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/data/repositories/faq_image_delete_repository_impl.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_image_delete_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/delete_faq_image_use_case.dart';

void faqDeleteImageConfig() async {
  GetIt.instance.registerLazySingleton<FaqImageDeleteRepository>(
      () => FaqImageDeleteRepositoryImpl(GetIt.instance.get()));

  GetIt.instance
      .registerFactory(() => DeleteFaqImageUseCase(GetIt.instance.get()));
}
