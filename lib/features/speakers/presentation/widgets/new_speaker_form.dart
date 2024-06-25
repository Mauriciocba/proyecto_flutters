import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/features/social_media/presentation/widgets/widget_form_social_media.dart';
import 'package:pamphlets_management/features/speakers/presentation/bloc/bloc/create_speaker_bloc.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../utils/common/custom_elevate_button.dart';
import '../../../../utils/common/custom_textfield.dart';

class NewSpeakerForm extends StatefulWidget {
  final int _eventId;
  const NewSpeakerForm({super.key, required int eventId}) : _eventId = eventId;

  @override
  State<NewSpeakerForm> createState() => _NewSpeakerFormState();
}

class _NewSpeakerFormState extends State<NewSpeakerForm> {
  UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameSpeaker = TextEditingController();
  final TextEditingController _lastNameSpeaker = TextEditingController();
  final TextEditingController _descriptionSpeaker = TextEditingController();
  final TextEditingController _photoSpeaker = TextEditingController();
  final TextEditingController? somNameSocialMedia = TextEditingController();
  final TextEditingController? somUrlSocialMedia = TextEditingController();
  List<SocialMediaModel> socialMediaList = [];

  @override
  void dispose() {
    _nameSpeaker.dispose();
    _lastNameSpeaker.dispose();
    _descriptionSpeaker.dispose();
    _photoSpeaker.dispose();
    somNameSocialMedia?.dispose();
    somUrlSocialMedia?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Completa los siguientes datos para registrar un Speaker",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "* Datos obligatorios",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            WidgetImagePickerButton(
              key: _widgetUniqueKey,
              onImageSelected: (path) {
                _photoSpeaker.text = path;
              },
            ),
            const Tooltip(
              message: 'Foto Speaker',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Nombre",
                    controller: _nameSpeaker,
                    prefix: const Icon(Icons.person_sharp),
                    validator: (name) {
                      if (name == null || name == "" || name.trim().isEmpty) {
                        return "Debes completar el Nombre del Speaker";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Apellido",
                    controller: _lastNameSpeaker,
                    prefix: const Icon(Icons.person_sharp),
                    validator: (lastName) {
                      if (lastName == null ||
                          lastName == "" ||
                          lastName.trim().isEmpty) {
                        return "Debes completar el Apellido del Speaker";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Descripción",
                    controller: _descriptionSpeaker,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (description) {
                      if (description == null ||
                          description.isEmpty ||
                          description.trim().isEmpty) {
                        return "Debes completar la descripción";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Completa los siguientes datos para registrar una Red social",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            WidgetFormSocialMedia(
              somName: somNameSocialMedia,
              somUrl: somUrlSocialMedia,
              socialMediaList: socialMediaList,
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: CustomTextButton(
                  label: const Text("Guardar"),
                  expanded: false,
                  onPressed: () => newSpeaker(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> encodeImageFile(String? imageUrl) async {
    if (imageUrl == null) {
      return null;
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

  void newSpeaker(BuildContext context) async {
    BlocProvider.of<CreateSpeakerBloc>(context)
        .add(SpeakerFormEvent(speakerForm: (
      eventId: widget._eventId,
      name: _nameSpeaker.text,
      lastName: _lastNameSpeaker.text,
      description: _descriptionSpeaker.text,
      photo: await encodeImageFile(_photoSpeaker.text)
    ), speakerSocialMedia: socialMediaList));

    resetTextFields();
  }

  void resetTextFields() {
    _formKey.currentState!.reset();
    setState(() {
      // socialMediaList.clear();
      _widgetUniqueKey = UniqueKey();
    });
  }
}
