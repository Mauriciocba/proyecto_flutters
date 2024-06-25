import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_create/domain/entities/stands_model.dart';
import 'package:pamphlets_management/features/stand_create/presentation/bloc/stands_create_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

class FormStandsWidget extends StatefulWidget {
  final int _eventId;
  const FormStandsWidget({super.key, required int eventId})
      : _eventId = eventId;

  @override
  State<FormStandsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<FormStandsWidget> {
  UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _std_name = TextEditingController();
  final TextEditingController _std_name_company = TextEditingController();
  final TextEditingController _std_description = TextEditingController();
  final TextEditingController _std_number = TextEditingController();
  final TextEditingController _std_referent = TextEditingController();
  final TextEditingController _std_logo = TextEditingController();

  bool _std_startup = false;

  @override
  void dispose() {
    _std_name.dispose();
    _std_name_company.dispose();
    _std_description.dispose();
    _std_number.dispose();
    _std_referent.dispose();
    _std_logo.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
              "Completa los siguientes datos para registrar un Stand",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "* Datos obligatorios",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetImagePickerButton(
                  key: _widgetUniqueKey,
                  onImageSelected: (path) {
                    _std_logo.text = path;
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Nombre del stand",
                    controller: _std_name,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (name) {
                      if (name == null || name == "" || name.trim().isEmpty) {
                        return "Debes completar el Nombre del Stand";
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
                    label: "* Descripción del stand",
                    controller: _std_description,
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Nombre de la compañía",
                    controller: _std_name_company,
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Número de stand",
                    tooltip: "Indique que número tendrá su stand",
                    controller: _std_number,
                    prefix: const Icon(Icons.pin_outlined),
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    tooltip: 'Ingrese el referente al stand',
                    label: "* Referente del stand",
                    controller: _std_referent,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (stdReferent) {
                      if (stdReferent == null ||
                          stdReferent == "" ||
                          stdReferent.trim().isEmpty) {
                        return "Debes ingresar un referente al stand";
                      }
                      return null;
                    },
                  ),
                ),
              ],
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
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: CustomTextButton(
                  label: BlocBuilder<StandsCreateBloc, StandsCreateState>(
                      builder: (context, state) {
                    if (state is StandsCreateLoading) {
                      return const CupertinoActivityIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text("Guardar");
                  }),
                  expanded: false,
                  onPressed: () => standCreate(context),
                ),
              ),
            ),
            BlocBuilder<StandsCreateBloc, StandsCreateState>(
              builder: (context, state) {
                if (state is StandsCreateFailure) {
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

  Future<String> encodeImageFile(String? imageUrl) async {
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

  void standCreate(BuildContext context) async {
    if (_std_name.text.trim().isEmpty) {
      return null;
    }

    if (_std_description.text.trim().isEmpty) {
      return null;
    }

    BlocProvider.of<StandsCreateBloc>(context).add(StandsStart(
        stdModel: StandsModel(
            eveId: widget._eventId,
            stdName: _std_name.text,
            stdNameCompany: _std_name_company.text,
            stdDescription: _std_description.text,
            stdNumber: int.parse(_std_number.text),
            stdReferent: _std_referent.text,
            stdLogo: await encodeImageFile(_std_logo.text),
            stdStartup: _std_startup)));

    resetTextFields();
  }

  void resetTextFields() {
    _formKey.currentState!.reset();
    setState(() {
      _widgetUniqueKey = UniqueKey();
    });
  }
}
