import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';

import '../../../../core/errors/base_failure.dart';

abstract interface class AddressSuggestionsService {
  Future<Either<BaseFailure, AddressSuggestions>> getAddressSuggestions(
      String address, double? latitude, double? longitude);
}
