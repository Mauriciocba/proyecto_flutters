import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/forgot_password/domain/use_cases/register_validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/bloc/validation_password_bloc.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/bloc/verify_code_password_bloc.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/widgets/forgot_password_widget.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget with Toaster {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
          "Pamphlets",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: BlocProvider(          
            create: (_) => ValidationPasswordBloc(
                GetIt.instance.get<RegisterValidationPassword>()),
            child: MultiBlocListener(
              listeners: [
                BlocListener<ValidationPasswordBloc, ValidationPasswordState>(
                  listener: (context, state) {
                    if (state is ValidationPasswordFail) {
                      showToast(
                        context: context,
                        message: 'No se pudo enviar el Email',
                        isError: true,
                      );
                    }
                    if (state is ValidationPasswordSuccess) {
                      showToast(
                        context: context,
                        message: 'El código se ha enviado a su correo',
                      );
                    }
                  },
                ),
                BlocListener<VerifyCodePasswordBloc, VerifyCodePasswordState>(
                  listener: (context, state) {
                    if (state is VerifyCodePasswordFail) {
                      showToast(
                        context: context,
                        message: 'No se pudo verificar el Código',
                        isError: true,
                      );
                    }
                    if (state is VerifyCodePasswordSuccess) {
                      showToast(
                        context: context,
                        message: 'El código es correcto',
                      );
                    }
                  },
                )
              ],
              child: const SingleChildScrollView(
                child: Center(
                  child: ForgotPasswordWidget(),
                ),
              ),
            )));
  }
}
