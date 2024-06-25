part of 'account_list_bloc.dart';

sealed class AccountListEvent extends Equatable {
  const AccountListEvent();

  @override
  List<Object> get props => [];
}

class RequestedAccountList extends AccountListEvent {
  final int eventId;
  final int? page;
  final int? limit;
  final String? query;

  const RequestedAccountList({
    required this.eventId,
    this.page,
    this.limit,
    this.query,
  });
}
