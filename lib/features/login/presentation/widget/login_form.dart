import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/page/forgot_password_page.dart';
import 'package:pamphlets_management/features/login/presentation/bloc/login_bloc.dart';
import 'package:pamphlets_management/features/sign_up/presentation/page/sign_up_page.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/password_custom_textfield.dart';
import 'package:pamphlets_management/utils/extensions/strings_validations_extension.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(vertical: 8 * 4, horizontal: 8 * 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage("assets/logo.png"),
              width: 250,
            ),
            const SizedBox(height: 8 * 3),
            CustomTextField(
              label: "Email",
              hint: "micorreo@email.com",
              controller: _emailController,
              prefix: const Icon(Icons.mail_outlined),
              validator: _validateEmail,
            ),
            PasswordCustomTextField(
              label: "Contraseña",
              hint: "micontraseña",
              controller: _passwordController,
              prefix: const Icon(Icons.lock_outline_rounded),
              validator: _validatePassword,
            ),
            const SizedBox(
              height: 16.0,
            ),
            CustomTextButton(
              label: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginInProgress) {
                    return const CupertinoActivityIndicator(
                      color: Colors.white,
                    );
                  }
                  return const Text("Ingresar");
                },
              ),
              onPressed: () => _loginButtonPressed(context),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginFailure) {
                  return _ErrorMessage(state.errorMessage);
                }
                return const SizedBox();
              },
            ),
            Row(
              children: [
                const Text(("¿No tienes cuenta?")),
                TextButton(
                  onPressed: () => _registerButtonPressed(context),
                  child: const Text('Crear aquí'),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () => _forgotPasswordPressed(context),
                  child: const Text('Olvide contraseña'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _validatePassword(String? password) =>
      (password != null && password.isEmpty) ? "Ingrese su contraseña" : null;

  String? _validateEmail(String? email) =>
      (email != null && !email.isEmail()) ? "Ingrese un mail correcto" : null;

  void _loginButtonPressed(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(
      LoginPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _registerButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }
}

void _forgotPasswordPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ForgotPasswordPage(),
    ),
  );
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  const _ErrorMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
