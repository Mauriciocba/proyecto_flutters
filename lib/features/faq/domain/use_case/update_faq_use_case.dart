import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/faq/data/model/faq_response.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq_form.dart';
import 'package:pamphlets_management/features/faq/domain/repositories/faq_update_repository.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/delete_faq_image_use_case.dart';
import 'package:pamphlets_management/features/faq/domain/use_case/save_faq_image_use_case.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

final class UpdateFaqUseCase {
  final FaqUpdateRepository _faqUpdateRepository;
  final SaveFaqImageUseCase _saveFaqImageUseCase;
  final DeleteFaqImageUseCase _deleteFaqImageUseCase;

  UpdateFaqUseCase(
    this._faqUpdateRepository,
    this._saveFaqImageUseCase,
    this._deleteFaqImageUseCase,
  );

  Future<Either<BaseFailure, String>> call({
    required FaqForm newFaqData,
    required List<ImageFaq> currentImages,
  }) async {
    try {
      final Set<int> imageIdsToDelete = _getImageIdsToDelete(
        currentImages,
        newFaqData.images,
      );
      _deleteImages(imageIdsToDelete);

      final Set<String> newImagesToSave = _getNewImages(
        currentImages: currentImages,
        updatedImages: newFaqData.images,
      );

      _saveImages(newFaqData.faqId, newImagesToSave);

      return await _faqUpdateRepository.update(newFaqData);
    } catch (e) {
      return Left(BaseFailure(message: 'No se pudo completar la operación'));
    }
  }

  Set<int> _getImageIdsToDelete(
    List<ImageFaq> currentImages,
    List<String> updatedImages,
  ) {
    final Set<int> imageIdsToDelete = <int>{};

    for (var image in currentImages) {
      if (!updatedImages.contains(image.ifqImage)) {
        imageIdsToDelete.add(image.ifqId);
      }
    }
    return imageIdsToDelete;
  }

  void _deleteImages(Set<int> imageIds) async {
    for (var faqImageId in imageIds) {
      var result = await _deleteFaqImageUseCase(imageFaqId: faqImageId);

      if (result.isLeft()) {
        throw result.getLeft();
      }
    }
  }

  Set<String> _getNewImages({
    required List<ImageFaq> currentImages,
    required List<String> updatedImages,
  }) {
    final Set<String> newImagesToSave = <String>{};
    final List<String> onlyImageOfCurrentImages =
        currentImages.map((e) => e.ifqImage).toList();

    for (var image in updatedImages) {
      if (!onlyImageOfCurrentImages.contains(image)) {
        newImagesToSave.add(image);
      }
    }
    return newImagesToSave;
  }

  void _saveImages(int faqId, Set<String> newImages) async {
    for (var newImage in newImages) {
      var result = await _saveFaqImageUseCase(faqId: faqId, image: newImage);
      if (result.isLeft()) {
        throw Exception();
      }
    }
  }
}
