import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faq_create/faq_create_bloc_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/widgets/faq_image_picker.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CreateFaqForm extends StatefulWidget {
  final int eventId;
  final void Function() onConfirm;

  const CreateFaqForm(this.eventId, {super.key, required this.onConfirm});

  @override
  State<CreateFaqForm> createState() => _CreateFaqFormState();
}

class _CreateFaqFormState extends State<CreateFaqForm> with Toaster {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final List<String> urlsImages = [];

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaqCreateBloc, FaqCreateState>(
      listener: _listenFaqCreateBloc,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "Pregunta",
              hint: "Por ejemplo: ¿Es necesario presentar acreditación?",
              controller: _questionController,
              minLines: 3,
            ),
            CustomTextField(
              label: "Respuesta",
              hint:
                  "Por ejemplo: No es necesario presentar ninguna acreditación, el evento es totalmente gratuito y de libre acceso",
              controller: _answerController,
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
            FaqImagePicker(urlsImages),
            const SizedBox(height: 16),
            BlocBuilder<FaqCreateBloc, FaqCreateState>(
              builder: (_, state) {
                var isLoading = false;
                if (state is FaqCreateBlocLoading) {
                  isLoading = true;
                }
                return Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _faqCreatePressed,
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

  void _listenFaqCreateBloc(BuildContext context, FaqCreateState state) {
    if (state is FaqCreateBlocSuccess) {
      showToast(context: context, message: "Creado con éxito");
      _resetInputs();
      Navigator.pop(context);
      widget.onConfirm();
    }

    if (state is FaqCreateBlocFailure) {
      showToast(context: context, message: state.message);
    }
  }

  void _resetInputs() {
    _answerController.clear();
    _questionController.clear();
  }

  void _faqCreatePressed() {
    BlocProvider.of<FaqCreateBloc>(context).add(
      FaqCreatePressed(
        question: _questionController.text,
        answer: _answerController.text,
        eventId: widget.eventId,
        urlImages: urlsImages,
      ),
    );
  }
}
