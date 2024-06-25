import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/settings/presentation/bloc/password_updater_bloc.dart';
import 'package:pamphlets_management/features/settings/presentation/widgets/update_password_form.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordUpdaterBloc(GetIt.instance.get()),
      child: CardScaffold(
        appBar: const CustomAppBar(title: 'Configuraciones'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: const [
              UpdatePasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
