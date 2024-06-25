import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:pamphlets_management/features/login/presentation/bloc/login_bloc.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ElevatedButton.icon(
        style: const ButtonStyle().copyWith(
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 16.0),
          ),
        ),
        onPressed: () =>
            BlocProvider.of<LoginBloc>(context).add(GoogleLoginPressed()),
        icon: SvgPicture.asset(
          'google.svg',
          width: 24,
          height: 24,
        ),
        label: const Text("Iniciar con Google"),
      ),
    );
  }
}
