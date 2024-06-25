import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/home/domain/use_cases/token_checker_use_case.dart';
import 'package:pamphlets_management/features/location/domain/use_cases/request_permission_use_case.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_by_google_use_case.dart';
import 'package:pamphlets_management/features/login/domain/use_cases/login_use_case.dart';
import 'package:pamphlets_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:pamphlets_management/features/login/presentation/widget/login_form.dart';
import 'package:pamphlets_management/features/login/presentation/widget/login_google_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          GetIt.instance.get<LoginUseCase>(),
          GetIt.instance.get<TokenCheckerUseCase>(),
          GetIt.instance.get<LoginByGoogleUseCase>(),
          GetIt.instance.get<RequestPermissionUseCase>())
        ..add(LoadLogin()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is IsLogged) {
            context.go('/home');
          }
          if (state is LoginSuccess) {
            context.go('/home');
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginForm(),
                  const SizedBox(height: 16.0),
                  const LoginGoogleButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
