part of 'gallery_info_bloc.dart';

sealed class GalleryInfoState extends Equatable {
  const GalleryInfoState();

  @override
  List<Object> get props => [];
}

final class GalleryInfoInitial extends GalleryInfoState {}

final class GalleryInfoSuccess extends GalleryInfoState {
  final List<GalleryModel> galleryModel;

  const GalleryInfoSuccess({required this.galleryModel});
}

final class GalleryInfoFailure extends GalleryInfoState {
  final String msgFail;

  const GalleryInfoFailure({required this.msgFail});
}

final class GalleryInfoLoading extends GalleryInfoState {}
