import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/social_media/data/social_media_repository_impl.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';
import 'package:pamphlets_management/features/social_media/domain/use_case/register_social_media.dart';

import '../../../core/network/api_service.dart';

void socialMediaConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<SocialMediaRepository>(() =>
      SocialMediaRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      RegisterSocialMediaUseCase(GetIt.instance<SocialMediaRepository>()));
}
