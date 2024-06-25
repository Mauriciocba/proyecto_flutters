import 'package:dartz/dartz.dart';
import 'package:pamphlets_management/core/network/api_result.dart';
import 'package:pamphlets_management/core/network/api_service.dart';
import 'package:pamphlets_management/features/location/data/models/search_info_response.dart';
import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';
import 'package:pamphlets_management/features/location/domain/services/address_suggestion_service.dart';

import '../../../../core/errors/base_failure.dart';

class AddressSuggestionsImpl implements AddressSuggestionsService {
  final ApiService _apiService;
  AddressSuggestionsImpl({required ApiService apiService})
      : _apiService = apiService;
  @override
  Future<Either<BaseFailure, AddressSuggestions>> getAddressSuggestions(
      String address, double? latitude, double? longitude) async {
    try {
      final String url = latitude != null && longitude != null
          ? "https://photon.komoot.io/api/?q=$address&lat=$latitude&lon=$longitude&limit=5"
          : "https://photon.komoot.io/api/?q=$address&limit=5";
      final result = await _apiService.request(
        method: HttpMethod.get,
        url: url,
      );

      if (result.resultType == ResultType.failure) {
        return Left(BaseFailure(message: "Ruta inexistente."));
      }

      if (result.resultType == ResultType.error) {
        return Left(BaseFailure(message: "Error"));
      }
      return Right(AddressSuggestionsResponse.fromAddressSuggestionsResponse(
          AddressSuggestionsResponse.fromJson(result.body!)));
    } catch (e) {
      return Left(BaseFailure(message: ''));
    }
  }
}
