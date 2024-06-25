import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_update_bloc/faqs_update_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/widgets/update_faq_form.dart';

class UpdateFaqPage extends StatelessWidget {
  final Faq initialFaq;
  final void Function() confirmUpdateTap;
  const UpdateFaqPage({
    super.key,
    required this.initialFaq,
    required this.confirmUpdateTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqsUpdateBloc(GetIt.instance.get()),
      child: Column(
        children: [
          const _Header(),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: UpdateFaqForm(
                  initialFaq: initialFaq,
                  confirmUpdateTap: confirmUpdateTap,
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
            "Editar Pregunta Frecuente",
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
