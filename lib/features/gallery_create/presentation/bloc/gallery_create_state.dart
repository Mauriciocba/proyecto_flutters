part of 'gallery_create_bloc.dart';

sealed class GalleryCreateState extends Equatable {
  const GalleryCreateState();

  @override
  List<Object> get props => [];
}

final class GalleryCreateInitial extends GalleryCreateState {}

final class GallerySuccess extends GalleryCreateState {}

final class GalleryFailure extends GalleryCreateState {
  final String msgFail;

  const GalleryFailure({required this.msgFail});
}

final class GalleryLoading extends GalleryCreateState {}
