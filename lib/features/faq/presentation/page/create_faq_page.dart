import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faq_create/faq_create_bloc_bloc.dart';

import 'package:pamphlets_management/features/faq/presentation/widgets/create_faq_form.dart';

class CreateFaqPage extends StatelessWidget {
  final int eventId;
  final void Function() onConfirm;

  const CreateFaqPage(
      {super.key, required this.eventId, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqCreateBloc(
        GetIt.instance.get(),
        GetIt.instance.get(),
      ),
      child: Column(
        children: [
          const _Header(),
          const Divider(height: 1.0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CreateFaqForm(
                  eventId,
                  onConfirm: onConfirm,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    var titleMedium2 = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Crear nueva Pregunta Frecuente",
            style: titleMedium2?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            iconSize: 16,
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
