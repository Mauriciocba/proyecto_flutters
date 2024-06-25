import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/activities/data/repositories/activity_repository_impl.dart';
import 'package:pamphlets_management/features/activities/data/repositories/activity_speaker_repository_impl.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_repository.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_speaker_repository.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/assign_speaker_to_activity_use_case.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/edit_activity_use_case.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/get_activities_by_event_use_case.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/register_activity_use_case.dart';

void activitiesConfig() async {
  GetIt.instance.registerLazySingleton<ActivitySpeakerRepository>(
    () => ActivitySpeakerRepositoryImpl(
      apiService: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(
      apiService: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => GetActivitiesByEventUseCase(
      activityRepository: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => RegisterActivityUseCase(
      activityRepository: GetIt.instance.get(),
      assignSpeakerToSpeakerUseCase: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => AssignSpeakerToSpeakerUseCase(
      activitySpeakerRepository: GetIt.instance.get(),
    ),
  );

  GetIt.instance.registerFactory(
    () => EditActivityUseCase(
      activityRepository: GetIt.instance.get(),
    ),
  );
}
