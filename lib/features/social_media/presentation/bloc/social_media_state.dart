part of 'social_media_bloc.dart';

sealed class SocialMediaState extends Equatable {
  const SocialMediaState();

  @override
  List<Object> get props => [];
}

final class SocialMediaInitial extends SocialMediaState {}

class SocialMediaLoading extends SocialMediaState {}

class SocialMediaFailure extends SocialMediaState {
  final String msgFail;

  const SocialMediaFailure({required this.msgFail});
}

class SocialMediaSuccess extends SocialMediaState {}
