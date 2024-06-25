import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/entities/gallery_model.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/use_cases/get_gallery_info_use_case.dart';

part 'gallery_info_event.dart';
part 'gallery_info_state.dart';

class GalleryInfoBloc extends Bloc<GalleryInfoEvent, GalleryInfoState> {
  final GetGalleryInfoUseCase _galleryInfoUseCase;
  GalleryInfoBloc(this._galleryInfoUseCase) : super(GalleryInfoInitial()) {
    on<GalleryInfoStart>(onGalleryInfoEvent);
  }

  FutureOr<void> onGalleryInfoEvent(GalleryInfoStart event, emit) async {
    emit(GalleryInfoLoading());

    final failOrGalleryInfo = await _galleryInfoUseCase(event.eventId);

    failOrGalleryInfo.fold(
        (error) => emit(GalleryInfoFailure(msgFail: error.message)),
        (data) => emit(GalleryInfoSuccess(galleryModel: data)));
  }
}
