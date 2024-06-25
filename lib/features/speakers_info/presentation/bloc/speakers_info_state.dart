part of 'speakers_info_bloc.dart';

sealed class SpeakersInfoState extends Equatable {
  final int? eventId;
  final int? page;
  final int? limit;
  final String? query;
  const SpeakersInfoState({
    this.eventId,
    this.page,
    this.limit,
    this.query,
  });

  @override
  List<Object> get props => [];
}

final class SpeakersInfoInitial extends SpeakersInfoState {}

final class SpeakersInfoSuccess extends SpeakersInfoState {
  final List<SpeakersModel> listSpeakers;

  const SpeakersInfoSuccess({
    required this.listSpeakers,
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}

final class SpeakersInfoLoading extends SpeakersInfoState {
  const SpeakersInfoLoading({
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}

final class SpeakersInfoFailure extends SpeakersInfoState {
  final String msgError;

  const SpeakersInfoFailure({
    required this.msgError,
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}
