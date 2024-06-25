import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/social_media/domain/repositories/social_media_repository.dart';

import 'package:pamphlets_management/features/speakers/data/speakers_repository_impl.dart';
import 'package:pamphlets_management/features/speakers/domain/repositories/speaker_repository.dart';
import 'package:pamphlets_management/features/speakers/domain/use_case/register_speaker_use_case.dart';

import '../../../core/network/api_service.dart';

void speakerConfigure() {
  //Repositories
  GetIt.instance.registerSingleton<SpeakerRepository>(
      SpeakersRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
    ()=> RegisterSpeakerUseCase(GetIt.instance<SpeakerRepository>(),GetIt.instance<SocialMediaRepository>()));
}
