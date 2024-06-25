import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/gallery_create/domain/entities/gallery_create_model.dart';
import 'package:pamphlets_management/features/gallery_create/domain/use_cases/register_gallery_create_use_case.dart';

part 'gallery_create_event.dart';
part 'gallery_create_state.dart';

class GalleryCreateBloc extends Bloc<GalleryCreateEvent, GalleryCreateState> {
  final RegisterGalleryCreateUseCase _registerGalleryCreateUseCase;
  GalleryCreateBloc(this._registerGalleryCreateUseCase)
      : super(GalleryCreateInitial()) {
    on<GalleryCreateStart>(galleryOnEvent);
  }

  FutureOr<void> galleryOnEvent(GalleryCreateStart event, emit) async {
    emit(GalleryLoading());

    final result = await _registerGalleryCreateUseCase(event.galleryCreate);

    result.fold((error) => emit(GalleryFailure(msgFail: error.message)),
        (data) => emit(GallerySuccess()));
  }
}
