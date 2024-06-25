import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/sign_up/domain/use_cases/sign_up_use_cases.dart';
import 'package:pamphlets_management/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:pamphlets_management/features/sign_up/presentation/widgets/signup_form.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class SignUpPage extends StatelessWidget with Toaster {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(GetIt.instance.get<SignUpUseCase>()),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: _listenSingUpBloc,
        child: const Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: SignUpForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listenSingUpBloc(context, state) {
    if (state is SignUpLoadFailure) {
      showToast(
        context: context,
        message: 'Falló la creación de la cuenta',
        isError: true,
      );
    }
    if (state is SignUpLoadSuccess) {
      _showRegisterSuccessDialog(context);
    }
  }

  void _showRegisterSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog(
          title: 'Creación exitosa',
          description:
              'Cuenta creada, se le envió un código a su email registrado. Puede tener demora el envío',
          confirmLabel: 'Aceptar',
          confirm: () => context.pop(),
        );
      },
    );
  }
}
