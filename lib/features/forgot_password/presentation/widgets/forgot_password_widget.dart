import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/forgot_password/domain/entities/validation_password.dart';
import 'package:pamphlets_management/features/forgot_password/presentation/bloc/validation_password_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import '../../../../utils/common/custom_textfield.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final GlobalKey<FormState> _formKeyForgotPassword = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyForgotPassword,
      child: Center(
        child: SizedBox(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Ingrese su correo electrónico para obtener el código necesario para recuperar su contraseña.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200.0),
                child: CustomTextField(
                  hint: 'ejemploCorreo@gmail.com',
                  controller: _emailController,
                  prefix: const Icon(Icons.label_outline_rounded),
                  validator: (name) {
                    if (name == null || name == "" || name.trim().isEmpty) {
                      return "Debe ingresar su correo";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child: CustomTextButton(
                    label: BlocBuilder<ValidationPasswordBloc,
                        ValidationPasswordState>(builder: (context, state) {
                      if (state is ValidationPasswordLoading) {
                        return const CupertinoActivityIndicator(
                          color: Colors.white,
                        );
                      }
                      return const Text("Enviar");
                    }),
                    expanded: false,
                    onPressed: () => emailSend(context),
                  ),
                ),
              ),
              BlocBuilder<ValidationPasswordBloc, ValidationPasswordState>(
                builder: (context, state) {
                  if (state is ValidationPasswordFail) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(state.msgFail),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  emailSend(BuildContext context) async {
    if (_emailController.text.trim().isEmpty) {
      return null;
    }
    BlocProvider.of<ValidationPasswordBloc>(context).add(
        ValidationPasswordStart(
            validationEmail: ValidationEmail(email: _emailController.text)));
  }
}
