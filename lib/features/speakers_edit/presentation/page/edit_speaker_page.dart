import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/use_case/edit_speakers_use_case.dart';
import 'package:pamphlets_management/features/speakers_edit/presentation/bloc/edit_speaker_bloc.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../utils/common/widget_image_picker_button.dart';
import '../../domain/entities/speaker_edit_model.dart';

class EditSpeakerPage extends StatelessWidget with Toaster {
  final SpeakerEditModel speakerModel;

  const EditSpeakerPage({super.key, required this.speakerModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditSpeakerBloc(GetIt.instance.get<EditSpeakersUseCase>()),
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Editar Speaker",
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24.0,
          ),
          child: BlocListener<EditSpeakerBloc, EditSpeakerState>(
            listener: (context, state) {
              if (state is EditSpeakerSuccess) {
                showToast(context: context, message: "Speaker actualizado");
                Navigator.of(context).pop();
              }
              if (state is EditSpeakerFailure) {
                showToast(
                  context: context,
                  message: "No se pudo realizar los cambios",
                  isError: true,
                );
              }
              if (state is LoadFormSpeakersFail) {
                showToast(
                  context: context,
                  message: "Hubo un problema, intente nuevamente",
                  isError: true,
                );
              }
            },
            child: BlocBuilder<EditSpeakerBloc, EditSpeakerState>(
              builder: (context, state) {
                if (state is EditSpeakerLoading) {
                  return const CupertinoActivityIndicator();
                }
                return _EditSpeakerForm(
                  speakerModel: speakerModel,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EditSpeakerForm extends StatefulWidget {
  final SpeakerEditModel speakerModel;

  const _EditSpeakerForm({required this.speakerModel});

  @override
  State<_EditSpeakerForm> createState() => _EditSpeakerFormState();
}

class _EditSpeakerFormState extends State<_EditSpeakerForm> {
  final TextEditingController _speNameController = TextEditingController();
  final TextEditingController _speLastNameController = TextEditingController();
  final TextEditingController _speDescriptionController =
      TextEditingController();
  TextEditingController _photoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _speNameController.text = widget.speakerModel.speFirstName;
    _speLastNameController.text = widget.speakerModel.speLastName;
    _speDescriptionController.text = widget.speakerModel.speDescription;
    _photoController =
        TextEditingController(text: widget.speakerModel.spePhoto);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Modifica el speaker y presiona en guardar para confirmar los cambios",
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              WidgetImagePickerButton(
                image: widget.speakerModel.spePhoto,
                onImageSelected: (path) {
                  _photoController.text = path;
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomTextField(
            label: "Nombre",
            controller: _speNameController,
            prefix: const Icon(Icons.label_outline_rounded),
          ),
          CustomTextField(
            controller: _speLastNameController,
            label: "Apellido",
            prefix: const Icon(Icons.label_outline_rounded),
          ),
          CustomTextField(
            controller: _speDescriptionController,
            label: "Descripción",
            prefix: const Icon(Icons.label_outline_rounded),
          ),
          Container(
            alignment: Alignment.center,
            child: CustomTextButton(
              label: const Text("Guardar"),
              expanded: false,
              onPressed: () async {
                context.read<EditSpeakerBloc>().add(EditSpeakerConfirmed(
                        speakersModel: SpeakerEditModel(
                      speId: widget.speakerModel.speId,
                      eveId: widget.speakerModel.eveId,
                      speFirstName: _speNameController.text,
                      speLastName: _speLastNameController.text,
                      speDescription: _speDescriptionController.text,
                      spePhoto: await encodeImageFiles(_photoController.text),
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> encodeImageFiles(String? imageUrl) async {
  if (imageUrl == null) {
    return '';
  }

  final response = await html.HttpRequest.request(
    imageUrl,
    responseType: 'blob',
  );

  final reader = html.FileReader();
  reader.readAsDataUrl(response.response as html.Blob);
  await reader.onLoad.first;

  final result = reader.result as String;

  List<String> resultSplit = result.split(',');

  final String resultOk = resultSplit[1].trim();

  return resultOk;
}
