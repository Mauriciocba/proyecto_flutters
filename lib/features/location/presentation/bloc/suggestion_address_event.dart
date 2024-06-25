part of 'suggestion_address_bloc.dart';

sealed class SuggestionAddressEvent extends Equatable {
  const SuggestionAddressEvent();

  @override
  List<Object> get props => [];
}

class SearchAddress extends SuggestionAddressEvent {
  final String address;
  const SearchAddress({required this.address});
}
