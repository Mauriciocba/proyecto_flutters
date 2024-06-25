part of 'gallery_delete_bloc.dart';

sealed class GalleryDeleteState extends Equatable {
  const GalleryDeleteState();

  @override
  List<Object> get props => [];
}

final class GalleryDeleteInitial extends GalleryDeleteState {}

final class GalleryDeleteSuccess extends GalleryDeleteState {}

final class GalleryDeleteLoading extends GalleryDeleteState {}

final class GalleryDeleteFailure extends GalleryDeleteState {
  final String msgFail;

  const GalleryDeleteFailure({required this.msgFail});
}
