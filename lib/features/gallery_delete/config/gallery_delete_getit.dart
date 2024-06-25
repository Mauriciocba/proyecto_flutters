import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/gallery_delete/data/gallery_delete_repository_impl.dart';
import 'package:pamphlets_management/features/gallery_delete/domain/use_cases/delete_gallery_use_case.dart';

import '../domain/repositories/gallery_delete_repository.dart';



void deleteGalleryGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<GalleryDeleteRepository>(
      () => GalleryDeleteRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
     DeleteGalleryUseCase(GetIt.instance<GalleryDeleteRepository>()));
}