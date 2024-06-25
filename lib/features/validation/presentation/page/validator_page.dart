import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/validation/domain/use_cases/verify_code_use_case.dart';
import 'package:pamphlets_management/features/validation/presentation/bloc/verify_code_bloc.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

import '../widgets/constants.dart';
import '../widgets/otp_form.dart';

class ValidatorPage extends StatelessWidget with Toaster {
  const ValidatorPage({super.key, required this.userId});

  final int userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VerifyCodeBloc(GetIt.instance.get<GetVerifyCodeUseCase>()),
      child: BlocListener<VerifyCodeBloc, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeSuccess) {
            showToast(context: context, message: 'Validación completada');
            context.go('/');
          }
          if (state is VerifyCodeFailure) {
            showToast(
                context: context,
                message: 'Validación fallida, intente nuevamente',
                isError: true);
          }
        },
        child: Scaffold(
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
          body: Center(
            child: SingleChildScrollView(
              child: Card(
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8 * 4, horizontal: 8 * 3),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Image.asset('image_otp.png',
                          height: MediaQuery.of(context).size.height * 0.25),
                      const SizedBox(height: 16),
                      const Text(
                        "Verificación de código",
                        style: Constants.headingStyle,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: OtpForm(userId: userId)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
