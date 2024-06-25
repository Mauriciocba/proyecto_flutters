import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/speakers_info/data/speakers_info_repository_impl.dart';
import 'package:pamphlets_management/features/speakers_info/domain/repositories/speakers_info_repository.dart';

import '../../../core/network/api_service.dart';
import '../domain/use_case/speakers_info_use_case.dart';

void speakerInfoConfigure() {
  //Repositories
  GetIt.instance.registerLazySingleton<SpeakersInfoRepository>(() =>
      SpeakersInfoRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerSingleton(
      GetSpeakersInfoUseCase(GetIt.instance<SpeakersInfoRepository>()));
}
