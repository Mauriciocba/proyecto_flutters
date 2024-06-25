import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';
import 'package:pamphlets_management/features/accounts/domain/use_cases/get_users_accounts_by_event_use_case.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final GetUsersAccountsByEventUseCase _accountsByEventUseCase;

  AccountListBloc(this._accountsByEventUseCase)
      : super(const AccountListInitial()) {
    on<RequestedAccountList>((event, emit) async {
      emit(AccountListLoading(
        eventId: event.eventId,
        page: event.page,
        limit: event.limit,
        query: event.query,
      ));

      final failOrData = await _accountsByEventUseCase.call(
        eventId: event.eventId,
        page: event.page,
        limit: state.limit,
        search: event.query,
      );

      failOrData.fold(
        (fail) => emit(AccountListLoadFailure(
          errorMessage: fail.message,
          eventId: event.eventId,
          page: event.page,
          limit: event.limit,
          query: event.query,
        )),
        (accounts) => emit(AccountListLoadSuccess(
          accounts: accounts,
          eventId: event.eventId,
          page: event.page,
          limit: event.limit,
          query: event.query,
        )),
      );
    });
  }
}
