import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/repositories/activity_repository.dart';
import 'package:pamphlets_management/features/activities/domain/use_case/assign_speaker_to_activity_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

final class RegisterActivityUseCase {
  final ActivityRepository _activityRepository;
  final AssignSpeakerToSpeakerUseCase _assignSpeakerToSpeakerUseCase;

  RegisterActivityUseCase({
    required ActivityRepository activityRepository,
    required AssignSpeakerToSpeakerUseCase assignSpeakerToSpeakerUseCase,
  })  : _activityRepository = activityRepository,
        _assignSpeakerToSpeakerUseCase = assignSpeakerToSpeakerUseCase;

  Future<Either<BaseFailure, Activity>> call({
    required ActivityFormInput activityForm,
  }) async {
    if (activityForm.name.trim().isEmpty) {
      return Left(BaseFailure(message: "Debe contener un nombre"));
    }

    if (activityForm.description.isEmpty) {
      return Left(BaseFailure(message: "Debe contener una descripción"));
    }

    if (activityForm.eventId.isNegative) {
      return Left(BaseFailure(message: "El evento no existe"));
    }

    final ActivityFormInput inputData = (
      description: activityForm.description,
      name: activityForm.name,
      eventId: activityForm.eventId,
      start: activityForm.start,
      end: activityForm.end,
      location: _validateLocation(activityForm),
      urlForm: _validateForm(activityForm),
      actAsk: activityForm.actAsk,
      speakerIds: activityForm.speakerIds,
      categoryId: activityForm.categoryId
    );

    final result = await _activityRepository.save(inputData);

    if (result.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar la actividad"));
    }

    final assignmentSpeakersResult = await _assignSpeakerToSpeakerUseCase(
        activityId: result.getRight().activityId,
        speakerIds: activityForm.speakerIds);

    if (assignmentSpeakersResult.isLeft()) {
      return Left(BaseFailure(message: "No se pudo registrar los speakers"));
    }

    return Right(result.getRight());
  }

  String? _validateForm(ActivityFormInput activityForm) {
    if (activityForm.urlForm != null && activityForm.urlForm!.isNotEmpty) {
      return activityForm.urlForm;
    }
    return null;
  }

  String? _validateLocation(ActivityFormInput activityForm) {
    if (activityForm.location != null && activityForm.location!.isNotEmpty) {
      return activityForm.location;
    }
    return null;
  }
}

typedef ActivityFormInput = ({
  String name,
  String description,
  String? location,
  String? urlForm,
  bool actAsk,
  DateTime start,
  DateTime end,
  int eventId,
  List<int> speakerIds,
  int? categoryId,
});
