import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/get_address_suggestions_use_case.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/get_user_position_use_case.dart';
part 'suggestion_address_event.dart';
part 'suggestion_address_state.dart';

class SuggestionAddressBloc
    extends Bloc<SuggestionAddressEvent, SuggestionAddressState> {
  final AddressSuggestionsUseCase _addressSuggestionsUseCase;
  final GetUserPositionUseCase _getUserPositionUseCase;
  SuggestionAddressBloc(
      this._addressSuggestionsUseCase, this._getUserPositionUseCase)
      : super(SuggestionAddressInitial()) {
    on<SearchAddress>(_onSearchAddress);
  }

  FutureOr<void> _onSearchAddress(
      SearchAddress event, Emitter<SuggestionAddressState> emit) async {
    emit(const SuggestionAddressLoading());

    final position = await _getUserPositionUseCase.call();

    final failureOrData = await _addressSuggestionsUseCase.call(
        event.address, position.value1, position.value2);
    failureOrData.fold((error) {
      emit(SuggestionAddressFailure(errorMessage: error.message));
    }, (data) {
      if (data.features.isNotEmpty) {
        emit(SuggestionAddressSuccess(addressList: data));
      } else {
        emit(SuggestionAddressEmpty());
      }
    });
  }
}
