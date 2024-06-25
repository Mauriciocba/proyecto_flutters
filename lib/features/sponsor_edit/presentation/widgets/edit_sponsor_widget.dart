import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/bloc/edit_sponsors_bloc.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/widgets/category_sponsor_picker.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/tag.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

class EditSponsorWidget extends StatefulWidget {
  final int eventId;
  final SponsorsEditModel sponsorsModel;

  const EditSponsorWidget(
      {super.key, required this.sponsorsModel, required this.eventId});

  @override
  State<EditSponsorWidget> createState() => _EditSpeakerFormState();
}

class _EditSpeakerFormState extends State<EditSponsorWidget> {
  final UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _spoNameController = TextEditingController();
  final TextEditingController _spoDescriptionController =
      TextEditingController();
  final TextEditingController _spoUrlController = TextEditingController();
  TextEditingController _photoController = TextEditingController();
  SponsorsCategoryModel? _categorySelected;

  @override
  void initState() {
    super.initState();
    _categorySelected = widget.sponsorsModel.spcId != null &&
            widget.sponsorsModel.spcName != null
        ? SponsorsCategoryModel(
            spcId: widget.sponsorsModel.spcId!,
            spcName: widget.sponsorsModel.spcName!,
          )
        : null;

    _spoNameController.text = widget.sponsorsModel.spoName;
    _spoDescriptionController.text = widget.sponsorsModel.spoDescription;
    _spoUrlController.text = widget.sponsorsModel.spoUrl;

    _photoController =
        TextEditingController(text: widget.sponsorsModel.spoLogo);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifica el Sponsor y presiona en guardar para confirmar los cambios",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetImagePickerButton(
                  key: _widgetUniqueKey,
                  image: widget.sponsorsModel.spoLogo,
                  onImageSelected: (path) {
                    _photoController.text = path;
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Nombre Sponsor",
              controller: _spoNameController,
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (name) {
                if (name == null || name == "" || name.trim().isEmpty) {
                  return "Debes completar el nombre del sponsor";
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _spoDescriptionController,
              label: "Descripción Sponsor",
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (descriptionCompany) {
                if (descriptionCompany == null ||
                    descriptionCompany == "" ||
                    descriptionCompany.trim().isEmpty) {
                  return "Debes ingresar una descripción para sponsor";
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _spoUrlController,
              label: "Link del sitio",
              prefix: const Icon(Icons.link),
              validator: (nameCompany) {
                if (nameCompany == null ||
                    nameCompany == "" ||
                    nameCompany.trim().isEmpty) {
                  return "Debes ingresar un link";
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Categoría:",
                  textAlign: TextAlign.left,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16.0),
                if (_categorySelected != null)
                  Tag(
                    label: _categorySelected?.spcName ?? "",
                    description: _categorySelected?.spcDescription ?? "",
                    isSmall: false,
                  ),
                if (_categorySelected != null)
                  IconButton.filled(
                    onPressed: () {
                      setState(() {
                        _categorySelected = null;
                      });
                    },
                    iconSize: 16.0,
                    splashRadius: 20.0,
                    icon: const Icon(Icons.close),
                  ),
                if (_categorySelected == null)
                  CategorySponsorPicker(
                    eventId: widget.eventId,
                    (category) {
                      setState(() {
                        _categorySelected = category;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              child: CustomTextButton(
                label: BlocBuilder<EditSponsorsBloc, EditSponsorsState>(
                  builder: (context, state) {
                    if (state is EditSponsorsLoading) {
                      return const CupertinoActivityIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text("Guardar");
                  },
                ),
                expanded: false,
                onPressed: () async {
                  context.read<EditSponsorsBloc>().add(EditSponsorConfirmed(
                      spoModel: SponsorsEditModel(
                          spoId: widget.sponsorsModel.spoId,
                          eveId: widget.sponsorsModel.eveId,
                          spcId: _categorySelected?.spcId,
                          spoName: _spoNameController.text,
                          spoDescription: _spoDescriptionController.text,
                          spoLogo:
                              await encodeImageFiles(_photoController.text),
                          spoUrl: _spoUrlController.text)));
                },
              ),
            ),
            BlocBuilder<EditSponsorsBloc, EditSponsorsState>(
              builder: (context, state) {
                if (state is EditSponsorsFail) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(state.msgFail),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
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
