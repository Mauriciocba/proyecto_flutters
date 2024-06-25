import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';
import 'package:pamphlets_management/features/location/domain/services/address_suggestion_service.dart';
import 'package:pamphlets_management/utils/extensions/either_extensions.dart';

import '../../../../core/errors/base_failure.dart';

class AddressSuggestionsUseCase {
  final AddressSuggestionsService _addressSuggestionsService;
  AddressSuggestionsUseCase(this._addressSuggestionsService);

  Future<Either<BaseFailure, AddressSuggestions>> call(
      String address, double? latitude, double? longitude) async {
    final listAddressSuggestion = await _addressSuggestionsService
        .getAddressSuggestions(address, latitude, longitude);

    if (listAddressSuggestion.isLeft()) {
      return left(
          BaseFailure(message: listAddressSuggestion.getLeft().message));
    }
    return Right(listAddressSuggestion.getRight());
  }
}
