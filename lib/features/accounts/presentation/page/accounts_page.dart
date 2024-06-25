import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/accounts/presentation/bloc/account_list_bloc.dart';
import 'package:pamphlets_management/features/accounts/presentation/widget/account_list.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/page/popup_menu_handler.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/pagination_bar.dart';
import 'package:pamphlets_management/utils/common/search_field.dart';

class AccountsPage extends StatefulWidget {
  final int _eventId;
  final String eventName;

  const AccountsPage(this._eventId, this.eventName, {super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final _limitOfResultsPerPage = 10;

  final _initialPage = 1;
  late bool activeMenuOption = false;
  void _searchAccounts({
    required BuildContext context,
    required int page,
    required String? query,
  }) {
    if (page >= 0) {
      BlocProvider.of<AccountListBloc>(context).add(
        RequestedAccountList(
          eventId: widget._eventId,
          page: page,
          limit: _limitOfResultsPerPage,
          query: query,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountListBloc(GetIt.instance.get())
        ..add(
          RequestedAccountList(
            eventId: widget._eventId,
            page: _initialPage,
            limit: _limitOfResultsPerPage,
          ),
        ),
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Usuarios registrados",
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          trailing: activeMenuOption
              ? PopupMenuHandler(
                  popupMenuItemsGroup: PopupMenuItemsGroup.users,
                  eventName: widget.eventName,
                  eventId: widget._eventId)
              : null,
        ),
        body: BlocListener<AccountListBloc, AccountListState>(
          listener: (context, state) {
            switch (state) {
              case AccountListLoadSuccess accountListSuccess:
                accountListSuccess.accounts.isEmpty
                    ? setState(() => activeMenuOption = false)
                    : setState(() => activeMenuOption = true);

                break;
              default:
            }
          },
          child: Builder(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(4.0),
                  child: SearchField(onSearchSubmit: _searchAccounts),
                ),
                const Divider(height: 1.0),
                Expanded(
                  child: Center(
                    child: BlocBuilder<AccountListBloc, AccountListState>(
                      builder: (context, state) {
                        return Container(
                          child: switch (state) {
                            AccountListInitial() => const SizedBox(),
                            AccountListLoading() =>
                              const CupertinoActivityIndicator(),
                            AccountListLoadSuccess() =>
                              AccountsList(accounts: state.accounts),
                            AccountListLoadFailure() =>
                              Text(state.errorMessage),
                          },
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<AccountListBloc, AccountListState>(
                  builder: (context, state) {
                    return PaginationBar(
                      currentPage: (state.page != null && state.page! == 0)
                          ? "Todos"
                          : "${state.page}",
                      previous: () => _searchAccounts(
                        context: context,
                        page: state.page != null ? state.page! - 1 : 1,
                        query: state.query,
                      ),
                      next: () => _searchAccounts(
                        context: context,
                        page: state.page != null ? state.page! + 1 : 1,
                        query: state.query,
                      ),
                    );
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
