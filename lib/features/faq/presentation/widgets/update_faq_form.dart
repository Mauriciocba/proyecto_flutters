import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq.dart';
import 'package:pamphlets_management/features/faq/domain/domain/faq_form.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_update_bloc/faqs_update_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/widgets/faq_image_picker.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class UpdateFaqForm extends StatefulWidget {
  final Faq initialFaq;
  final void Function() confirmUpdateTap;
  const UpdateFaqForm({
    super.key,
    required this.initialFaq,
    required this.confirmUpdateTap,
  });

  @override
  State<UpdateFaqForm> createState() => _UpdateFaqFormState();
}

class _UpdateFaqFormState extends State<UpdateFaqForm> with Toaster {
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  late List<String> imageUrl;

  @override
  void initState() {
    super.initState();
    _answerController.value = TextEditingValue(
      text: widget.initialFaq.answer,
    );
    _questionController.value = TextEditingValue(
      text: widget.initialFaq.question,
    );

    imageUrl = widget.initialFaq.images.map((e) => e.ifqImage).toList();
  }

  @override
  void dispose() {
    _answerController.dispose();
    _questionController.dispose();
    imageUrl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaqsUpdateBloc, FaqsUpdateState>(
      listener: _faqsUpdateListener,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _questionController,
              label: 'Pregunta',
              hint: 'Por ejemplo: ¿Es necesario presentar acreditación?',
              minLines: 3,
            ),
            CustomTextField(
              controller: _answerController,
              label: 'Respuesta',
              hint:
                  'Por ejemplo: No es necesario presentar ninguna acreditación, el evento es totalmente gratuito y de libre acceso',
              minLines: 3,
            ),
            const SizedBox(height: 16),
            Text(
              'Imágenes',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FaqImagePicker(imageUrl),
            const SizedBox(height: 16),
            BlocBuilder<FaqsUpdateBloc, FaqsUpdateState>(
              builder: (context, state) {
                var isLoading = false;
                if (state is FaqsUpdateLoading) {
                  isLoading = true;
                }

                return Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _updatePressed,
                    child: isLoading
                        ? const CupertinoActivityIndicator(color: Colors.white)
                        : const Text("Guardar"),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _faqsUpdateListener(context, state) {
    if (state is FaqsUpdateSuccess) {
      showToast(context: context, message: 'Actualizado exitosamente');
      Navigator.pop(context);
      widget.confirmUpdateTap();
    }

    if (state is FaqsUpdateFailure) {
      showToast(
        context: context,
        message: 'No se pudo actualizar',
        isError: true,
      );
    }
  }

  void _updatePressed() async {
    final FaqForm faqsData = (
      answer: _answerController.text,
      question: _questionController.text,
      faqId: widget.initialFaq.faqId,
      images: imageUrl,
    );

    BlocProvider.of<FaqsUpdateBloc>(context).add(
      FaqsUpdatePressed(
        faqsData: faqsData,
        currentImages: widget.initialFaq.images,
      ),
    );
  }
}
