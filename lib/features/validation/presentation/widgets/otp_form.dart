import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/validation/presentation/bloc/verify_code_bloc.dart';

import '../../../../utils/common/custom_elevate_button.dart';
import 'constants.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key, required this.userId});

  final int userId;

  @override
  OtpFormState createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.nextFocus();
    } else {
      focusNode!.previousFocus();
    }
  }

  String getCode() {
    String code = '';
    for (var controller in controllers) {
      code += controller.text;
    }
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[0],
                    focusNode: pin1FocusNode,
                    autofocus: true,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin1FocusNode);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[1],
                    focusNode: pin2FocusNode,
                    autofocus: true,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[2],
                    focusNode: pin3FocusNode,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) => nextField(value, pin3FocusNode),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[3],
                    focusNode: pin4FocusNode,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) => nextField(value, pin4FocusNode),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[4],
                    focusNode: pin5FocusNode,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) => nextField(value, pin5FocusNode),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  child: TextFormField(
                    controller: controllers[5],
                    focusNode: pin6FocusNode,
                    style: const TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: Constants.otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode!.unfocus();
                      } else {
                        pin6FocusNode!.previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          CustomTextButton(
            label: const Text('Verificar'),
            onPressed: () {
              String code = getCode();
              BlocProvider.of<VerifyCodeBloc>(context)
                  .add(StartVerifyCode(code: code, userId: widget.userId));
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              const Text('¿Desea iniciar sesión?'),
              TextButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: const Text('Ingresar aquí'))
            ],
          )
        ],
      ),
    );
  }
}
