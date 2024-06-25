import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/gallery_create/data/gallery_create_repository_impl.dart';
import 'package:pamphlets_management/features/gallery_create/domain/repositories/gallery_create_repository.dart';
import 'package:pamphlets_management/features/gallery_create/domain/use_cases/register_gallery_create_use_case.dart';

import '../../../core/network/api_service.dart';

void galleryCreateConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<GalleryCreateRepository>(
      GalleryCreateRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
    ()=> RegisterGalleryCreateUseCase(GetIt.instance<GalleryCreateRepository>()));
}