part of 'account_list_bloc.dart';

sealed class AccountListState extends Equatable {
  final int? eventId;
  final int? page;
  final int? limit;
  final String? query;

  const AccountListState({this.eventId, this.page, this.limit, this.query});
  @override
  List<Object?> get props => [];
}

final class AccountListInitial extends AccountListState {
  const AccountListInitial(
      {super.eventId, super.page, super.limit, super.query});
}

final class AccountListLoading extends AccountListState {
  const AccountListLoading(
      {super.eventId, super.page, super.limit, super.query});
}

final class AccountListLoadSuccess extends AccountListState {
  final List<Account> accounts;

  const AccountListLoadSuccess(
      {required this.accounts,
      super.eventId,
      super.page,
      super.limit,
      super.query});
}

final class AccountListLoadFailure extends AccountListState {
  final String errorMessage;

  const AccountListLoadFailure({
    required this.errorMessage,
    super.eventId,
    super.page,
    super.limit,
    super.query,
  });
}
