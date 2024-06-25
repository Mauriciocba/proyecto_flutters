part of 'suggestion_address_bloc.dart';

sealed class SuggestionAddressState extends Equatable {
  const SuggestionAddressState();

  @override
  List<Object> get props => [];
}

final class SuggestionAddressInitial extends SuggestionAddressState {}

class SuggestionAddressLoading extends SuggestionAddressState {
  const SuggestionAddressLoading();
}

class SuggestionAddressFailure extends SuggestionAddressState {
  final String errorMessage;
  const SuggestionAddressFailure({required this.errorMessage});
}

final class SuggestionAddressEmpty extends SuggestionAddressState {}

class SuggestionAddressSuccess extends SuggestionAddressState {
  final AddressSuggestions addressList;
  const SuggestionAddressSuccess({required this.addressList});
}
