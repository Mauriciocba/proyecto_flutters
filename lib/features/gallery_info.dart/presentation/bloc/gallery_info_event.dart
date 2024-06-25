part of 'gallery_info_bloc.dart';

sealed class GalleryInfoEvent extends Equatable {
  const GalleryInfoEvent();

  @override
  List<Object> get props => [];
}

final class GalleryInfoStart extends GalleryInfoEvent {
  final int eventId;

  const GalleryInfoStart({required this.eventId});
}
