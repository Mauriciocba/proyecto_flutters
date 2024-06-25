import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/presentation/bloc/edit_stand_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

class EditStandWidget extends StatefulWidget {
  final StandsEditModel standModel;

  const EditStandWidget({super.key, required this.standModel});

  @override
  State<EditStandWidget> createState() => _EditSpeakerFormState();
}

class _EditSpeakerFormState extends State<EditStandWidget> {
  final UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stdNameController = TextEditingController();
  final TextEditingController _stdDescriptionController =
      TextEditingController();
  final TextEditingController _stdNameCompanyController =
      TextEditingController();
  final TextEditingController _stdNumberController = TextEditingController();
  final TextEditingController _stdReferentController = TextEditingController();
  bool _std_startup = false;
  TextEditingController _photoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _stdNameController.text = widget.standModel.stdName;
    _stdDescriptionController.text = widget.standModel.stdDescription;
    _stdNameCompanyController.text = widget.standModel.stdNameCompany;
    _stdNumberController.text = widget.standModel.stdNumber.toString();
    _stdReferentController.text = widget.standModel.stdReferent;
    _std_startup = widget.standModel.stdStartup;

    _photoController = TextEditingController(text: widget.standModel.stdLogo);
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
              "Modifica el Stand y presiona en guardar para confirmar los cambios",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetImagePickerButton(
                  key: _widgetUniqueKey,
                  image: widget.standModel.stdLogo,
                  onImageSelected: (path) {
                    _photoController.text = path;
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Nombre stand",
              controller: _stdNameController,
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (name) {
                if (name == null || name == "" || name.trim().isEmpty) {
                  return "Debes completar el Nombre del Stand";
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _stdDescriptionController,
              label: "Descripción stand",
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (descriptionCompany) {
                if (descriptionCompany == null ||
                    descriptionCompany == "" ||
                    descriptionCompany.trim().isEmpty) {
                  return "Debes ingresar una descripción para compañía";
                }
                return null;
              },
            ),
            CustomTextField(
              controller: _stdNameCompanyController,
              label: "Nombre de la compañía",
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (nameCompany) {
                if (nameCompany == null ||
                    nameCompany == "" ||
                    nameCompany.trim().isEmpty) {
                  return "Debes ingresar el nombre de la compañía";
                }
                return null;
              },
            ),
            CustomTextField(
              tooltip: 'Indique que número tendrá su stand',
              controller: _stdNumberController,
              label: "Numero del stand",
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (stdNumber) {
                RegExp regExp = RegExp(r'^[0-9]+$');
                if (stdNumber == null || stdNumber.isEmpty) {
                  return "Debes asignar un número  al stand";
                } else if (!regExp.hasMatch(stdNumber)) {
                  return "Solo se permiten números";
                }
                return null;
              },
            ),
            CustomTextField(
              tooltip: 'Ingrese el referente al stand',
              controller: _stdReferentController,
              label: "Referente del stand",
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (stdReferent) {
                if (stdReferent == null ||
                    stdReferent == "" ||
                    stdReferent.trim().isEmpty) {
                  return "Debes ingresar una referente al stand";
                }
                return null;
              },
            ),
            Row(children: [
              const Text("  Startup",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Switch(
                  activeColor: const Color(0xFF7138FD),
                  activeTrackColor: const Color.fromARGB(255, 142, 102, 180),
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 5.0,
                  value: _std_startup,
                  onChanged: (value) {
                    setState(() {
                      _std_startup = value;
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              Tooltip(
                  message: "Empresa en desarrollo",
                  child: Icon(Icons.help_outline,
                      size: 16, color: Colors.grey.shade400))
            ]),
            Container(
              alignment: Alignment.center,
              child: CustomTextButton(
                label: BlocBuilder<EditStandBloc, EditStandState>(
                  builder: (context, state) {
                    if (state is EditStandLoading) {
                      return const CupertinoActivityIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text("Guardar");
                  },
                ),
                expanded: false,
                onPressed: () async {
                  context.read<EditStandBloc>().add(EditStandConfirmed(
                          standEdit: StandsEditModel(
                        stdId: widget.standModel.stdId,
                        stdName: _stdNameController.text,
                        stdNameCompany: _stdNameCompanyController.text,
                        stdDescription: _stdDescriptionController.text,
                        stdNumber: int.parse(_stdNumberController.text),
                        stdReferent: _stdReferentController.text,
                        stdStartup: _std_startup,
                        stdLogo: await encodeImageFiles(_photoController.text),
                      )));
                },
              ),
            ),
            BlocBuilder<EditStandBloc, EditStandState>(
              builder: (context, state) {
                if (state is EditStandFailure) {
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
