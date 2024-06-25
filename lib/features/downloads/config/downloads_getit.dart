import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/downloads/data/repository/download_repository_impl.dart';
import 'package:pamphlets_management/features/downloads/domain/repository/download_repository.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_activities_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_events_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_speakers_download_use_case.dart';
import 'package:pamphlets_management/features/downloads/domain/use_cases/get_users_download_use_case.dart';

void downloadsConfig() async {
  GetIt.instance.registerLazySingleton<DownloadRepository>(
    () => DownloadRepositoryImpl(
      apiService: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => GetEventsDownloadUseCase(
      GetIt.instance.get(),
    ),
  );
  GetIt.instance.registerFactory(
    () => GetActivitiesDownloadUseCase(
      GetIt.instance.get(),
    ),
  );
  GetIt.instance.registerFactory(
    () => GetSpeakersDownloadUseCase(
      GetIt.instance.get(),
    ),
  );
  GetIt.instance.registerFactory(
    () => GetUsersDownloadUseCase(
      GetIt.instance.get(),
    ),
  );
}
