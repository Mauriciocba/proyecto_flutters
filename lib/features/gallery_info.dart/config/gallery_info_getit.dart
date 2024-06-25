import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/gallery_info.dart/data/gallery_info_repository_impl.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/repositories/gallery_info_repository.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/use_cases/get_gallery_info_use_case.dart';

import '../../../core/network/api_service.dart';


void galleryInfoConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<GalleryInfoRepository>(() =>
      GalleryInfoRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetGalleryInfoUseCase(GetIt.instance<GalleryInfoRepository>()));
}