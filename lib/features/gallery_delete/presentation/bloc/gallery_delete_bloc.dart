import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/gallery_delete/domain/use_cases/delete_gallery_use_case.dart';

part 'gallery_delete_event.dart';
part 'gallery_delete_state.dart';

class GalleryDeleteBloc extends Bloc<GalleryDeleteEvent, GalleryDeleteState> {
  final DeleteGalleryUseCase _deleteGalleryUseCase;
  GalleryDeleteBloc(this._deleteGalleryUseCase)
      : super(GalleryDeleteInitial()) {
    on<DeleteGallery>(onGalleryDelete);
  }

  FutureOr<void> onGalleryDelete(DeleteGallery event, emit) async {
    emit(GalleryDeleteLoading());

    final failOrDeleteGallery = await _deleteGalleryUseCase(event.galleryId);

    failOrDeleteGallery.fold(
        (error) => emit(GalleryDeleteFailure(msgFail: error.message)),
        (data) => emit(GalleryDeleteSuccess()));
  }
}
