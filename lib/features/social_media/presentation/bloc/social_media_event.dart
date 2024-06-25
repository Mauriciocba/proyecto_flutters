part of 'social_media_bloc.dart';

sealed class SocialMediaEvent extends Equatable {
  const SocialMediaEvent();

  @override
  List<Object> get props => [];
}

class SocialMediaStart extends SocialMediaEvent {
  final SocialMediaModel socialMedia;

  const SocialMediaStart({required this.socialMedia});
}
