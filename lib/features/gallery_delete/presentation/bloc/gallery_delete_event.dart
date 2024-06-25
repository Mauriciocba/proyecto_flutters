part of 'gallery_delete_bloc.dart';

sealed class GalleryDeleteEvent extends Equatable {
  const GalleryDeleteEvent();

  @override
  List<Object> get props => [];
}

class DeleteGallery extends GalleryDeleteEvent {
  final int galleryId;

  const DeleteGallery({required this.galleryId});
}