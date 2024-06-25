import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/accounts/domain/entities/account.dart';

class AccountTile extends StatelessWidget {
  final Account _account;
  const AccountTile(this._account, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tileColor: Theme.of(context).colorScheme.background,
        leading: const Icon(Icons.person_outlined),
        title: Text(_account.mail),
      ),
    );
  }
}
