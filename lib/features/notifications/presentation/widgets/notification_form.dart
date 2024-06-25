// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/notifications/presentation/bloc/notifier_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';

class NotificationForm extends StatelessWidget {
  final int eventId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  NotificationForm({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotifierBloc, NotifierState>(
      listener: (context, state) {
        if (state is NotifierSuccess) {
          _formKey.currentState?.reset();
        }
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            children: [
              CustomTextField(
                label: "Título",
                controller: _titleController,
                validator: (title) {
                  if (title == null || title == "" || title.trim().isEmpty) {
                    return "Debes completar el título de la actividad";
                  }
                  return null;
                },
              ),
              CustomTextField(
                label: "Mensaje",
                minLines: 5,
                controller: _messageController,
                validator: (mensaje) {
                  if (mensaje == null ||
                      mensaje == "" ||
                      mensaje.trim().isEmpty) {
                    return "Debes completar el título de la actividad";
                  }
                  return null;
                },
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: BlocBuilder<NotifierBloc, NotifierState>(
                  builder: (context, state) {
                    bool isLoading = false;

                    if (state is NotifierInProgress) {
                      isLoading = true;
                    }

                    return ElevatedButton.icon(
                      icon: isLoading
                          ? const CupertinoActivityIndicator()
                          : const Icon(Icons.send, size: 16.0),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                context.read<NotifierBloc>().add(
                                      NotifierSendPressed(
                                        title: _titleController.text,
                                        message: _messageController.text,
                                        eventId: eventId,
                                      ),
                                    );
                              }
                            },
                      label: Text(isLoading ? 'Enviando...' : 'Enviar'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
