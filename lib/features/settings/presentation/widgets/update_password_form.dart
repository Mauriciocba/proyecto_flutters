import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/settings/presentation/bloc/password_updater_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/password_custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({super.key});

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> with Toaster {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController =
      TextEditingController(text: '');
  final TextEditingController _newPasswordRepeatController =
      TextEditingController(text: '');

  bool _enableUpdateButton = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordUpdaterBloc, PasswordUpdaterState>(
      listener: _onStateChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actualizar contraseña',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Actualiza tu contraseña para iniciar sesión en Pamphlet',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade100, width: 1),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  onChanged: _onFormChanged,
                  child: Column(
                    children: [
                      PasswordCustomTextField(
                        label: 'Contraseña actual',
                        controller: _currentPasswordController,
                        validator: _currentPasswordValidator,
                        prefix: const Icon(Icons.lock_outline_sharp),
                      ),
                      const SizedBox(height: 16),
                      PasswordCustomTextField(
                        label: 'Nueva contraseña',
                        controller: _newPasswordController,
                        validator: _currentPasswordValidator,
                        prefix: const Icon(Icons.lock_outline_sharp),
                      ),
                      PasswordCustomTextField(
                        label: 'Confirmar nueva contraseña',
                        controller: _newPasswordRepeatController,
                        validator: _newPasswordValidator,
                        prefix: const Icon(Icons.lock_outline_sharp),
                      ),
                      const SizedBox(height: 16),
                      CustomTextButton(
                        label: BlocBuilder<PasswordUpdaterBloc,
                            PasswordUpdaterState>(
                          builder: (context, state) {
                            if (state is PasswordUpdaterLoading) {
                              return const CupertinoActivityIndicator(
                                color: Colors.white,
                              );
                            }
                            return const Text('Actualizar');
                          },
                        ),
                        onPressed: _enableUpdateButton ? _updatePassword : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStateChanged(context, state) {
    if (state is PasswordUpdaterLoadSuccess) {
      showToast(context: context, message: state.message);
    }
    if (state is PasswordUpdaterLoadFailure) {
      showToast(context: context, message: state.errorMessage, isError: true);
    }
  }

  void _onFormChanged() {
    setState(() {
      _enableUpdateButton = _formKey.currentState!.validate();
    });
  }

  String? _currentPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    }
    if (value.length < 9) {
      return 'Su contraseña debe ser mayor a 9 caracteres';
    }
    return null;
  }

  String? _newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    }
    if (value.length < 9) {
      return 'Su contraseña debe ser mayor a 9 caracteres';
    }

    if (value != _newPasswordController.text) {
      return 'Debe coincidir con su nueva contraseña';
    }
    return null;
  }

  void _updatePassword() {
    BlocProvider.of<PasswordUpdaterBloc>(context).add(
      PasswordUpdaterUpdatePressed(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        newPasswordRepeat: _newPasswordRepeatController.text,
      ),
    );
  }
}
