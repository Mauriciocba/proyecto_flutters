part of 'gallery_create_bloc.dart';

sealed class GalleryCreateEvent extends Equatable {
  const GalleryCreateEvent();

  @override
  List<Object> get props => [];
}

final class GalleryCreateStart extends GalleryCreateEvent {
  final GalleryCreateModel galleryCreate;

  const GalleryCreateStart({required this.galleryCreate});
}
