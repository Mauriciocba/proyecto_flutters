import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';
import 'package:pamphlets_management/features/accounts/presentation/widget/account_tile.dart';

class AccountsList extends StatelessWidget {
  final List<Account> _accounts;
  const AccountsList({
    super.key,
    required List<Account> accounts,
  }) : _accounts = accounts;

  @override
  Widget build(BuildContext context) {
    if (_accounts.isEmpty) {
      return const Text("No se encontraron usuarios");
    }

    final accountsWidgets =
        _accounts.map((account) => AccountTile(account)).toList();

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Resultados",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...accountsWidgets,
      ],
    );
  }
}
