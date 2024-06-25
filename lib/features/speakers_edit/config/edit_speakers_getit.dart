

import 'package:get_it/get_it.dart';

import '../../../core/network/api_service.dart';
import '../data/edit_speakers_repository_impl.dart';
import '../domain/repositories/edit_speakers_repository.dart';
import '../domain/use_case/edit_speakers_use_case.dart';

void editSpeakersGetIt() {
  //Repositories
  GetIt.instance.registerSingleton<SpeakersEditRepository>(
      EditSpeakersRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

  //Use_case
  GetIt.instance.registerFactory(
    ()=> EditSpeakersUseCase(GetIt.instance<SpeakersEditRepository>()));
}
