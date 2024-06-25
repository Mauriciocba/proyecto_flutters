import 'package:get_it/get_it.dart';

import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/speakers_delete/data/delete_speaker_repository_impl.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/repository/delete_speakers_repository.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/use_case/delete_speakers_use_case.dart';


void deleteSpeakersGetIt() {
//Repositories
  GetIt.instance.registerLazySingleton<DeleteSpeakerRepository>(
      () => DeleteSpeakerRepositoryImpl(apiService: GetIt.instance.get<ApiService>()));

//Use cases
  GetIt.instance.registerSingleton(
      GetDeleteSpeakerUseCase(GetIt.instance<DeleteSpeakerRepository>()));
}