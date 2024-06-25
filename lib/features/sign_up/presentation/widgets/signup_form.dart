import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/password_custom_textfield.dart';
import 'package:pamphlets_management/utils/extensions/strings_validations_extension.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Crear cuenta",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 24),
          Text(
            "Completa tu registro para poder acceder a todas las funcionalidad de PAMPHLETS",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            label: "Email",
            controller: _mailController,
            validator: (value) {
              if (value == null || !value.isEmail()) {
                return "Ingrese un mail";
              }
              return null;
            },
          ),
          PasswordCustomTextField(
            label: "Contraseña",
            controller: _passwordController,
            validator: (value) {
              if (value == null || !value.isPasswordGreaterThan7digits()) {
                return "La contraseña debe ser mayor a 7 caracteres";
              }
              return null;
            },
          ),
          PasswordCustomTextField(
            label: "Repetir contraseña",
            controller: _repeatPasswordController,
            validator: (value) {
              if (value == null || value != _passwordController.text) {
                return "La contraseñas deben coincidir";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          CustomTextButton(
            label: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const CupertinoActivityIndicator(
                    color: Colors.white,
                  );
                }
                return const Text("Registrarme");
              },
            ),
            onPressed: () {
              if (_validateForm()) {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpPressed(
                    email: _mailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              const Text('¿Ya tienes una cuenta?'),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ingresar aquí'))
            ],
          )
        ],
      ),
    );
  }

  bool _validateForm() {
    return _formKey.currentState!.validate();
  }
}
