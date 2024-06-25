import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/location/presentation/widgets/input_address_suggestions.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/settings/list_utc.dart';

import '../../../../utils/common/custom_textfield.dart';
import '../../../../utils/common/date_format.dart';
import '../../../../utils/common/encode_image_file.dart';
import '../../domain/entities/create_event_model.dart';
import '../../domain/entities/setting_event_model.dart';
import '../bloc/create_event_bloc.dart';
import '../utils/event_form_helpers.dart';
import 'widgets.dart';

class WidgetFormCreateEvent extends StatefulWidget {
  const WidgetFormCreateEvent({super.key});

  @override
  State<WidgetFormCreateEvent> createState() => _WidgetFormCreateEventState();
}

class _WidgetFormCreateEventState extends State<WidgetFormCreateEvent>
    with Toaster {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController? logoController = TextEditingController();
  TextEditingController? iconController = TextEditingController();
  TextEditingController? photoController = TextEditingController();
  TextEditingController? subtitleController = TextEditingController();
  TextEditingController? additionalInfoController = TextEditingController();
  TextEditingController? siteWebController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? ubicationController = TextEditingController();
  TextEditingController? latitudeController = TextEditingController();
  TextEditingController? longitudeController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  final TextEditingController timeStartController = TextEditingController();
  final TextEditingController timeEndController = TextEditingController();
  final TextEditingController utcController = TextEditingController();
  final List<String> _listUtc = getListUtc();

  bool buttonEnabled = false;
  DateTime _selectedDateStart = DateTime.now();
  DateTime _selectedDateEnd = DateTime.now();
  String selectedLanguage = 'es';
  bool checkBoxTicket = false;
  bool checkBoxNetworking = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(validateInputs);
    descriptionController.addListener(validateInputs);
    timeStartController.text = formatterTime(DateTime.now());
    timeEndController.text = formatterTime(DateTime.now());
    _startController =
        TextEditingController(text: formatterDate(DateTime.now()));
    _endController = TextEditingController(text: formatterDate(DateTime.now()));
    utcController.text = _listUtc.first;
  }

  void validateInputs() {
    setState(() {
      buttonEnabled = nameController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    subtitleController?.dispose();
    additionalInfoController?.dispose();
    siteWebController?.dispose();
    addressController?.dispose();
    ubicationController?.dispose();
    logoController?.dispose();
    photoController?.dispose();
    iconController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400, minWidth: 360),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Column(
                children: [
                  WidgetImagePickerButton(
                    onImageSelected: (path) {
                      logoController!.text = path;
                    },
                  ),
                  const Text("Logo"),
                ],
              ),
              const SizedBox(width: 20.0),
              Column(
                children: [
                  WidgetImagePickerButton(
                    onImageSelected: (path) {
                      photoController!.text = path;
                    },
                  ),
                  const Text("Foto de portada"),
                ],
              ),
              const SizedBox(width: 20.0),
              Column(
                children: [
                  WidgetImagePickerButton(
                    onImageSelected: (path) {
                      iconController!.text = path;
                    },
                  ),
                  const Text("Icono"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Debe ingresar un nombre';
              }
              return null;
            },
            controller: nameController,
            decoration: const InputDecoration(
              labelText: '(*) Nombre',
              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Debe ingresar una descripción';
              }
              return null;
            },
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: '(*) Descripción',
              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: subtitleController,
            decoration: const InputDecoration(
              labelText: 'Subtitulo',
              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: additionalInfoController,
            decoration: const InputDecoration(
              labelText: 'Info adicional',
              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: siteWebController,
            decoration: const InputDecoration(
              labelText: 'Sitio web',
              contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: 20),
          WidgetAddressSuggestions(
              key: widget.key,
              addressController: addressController,
              onChangeLocation: (String lat, String long) {
                ubicationController!.text =
                    'https://maps.google.com/?q=$lat,$long';
                latitudeController?.text = lat;
                longitudeController?.text = long;
              }),
          const SizedBox(height: 20),
          TextFormField(
            controller: timeStartController,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: '(*) Seleccionar hora/minuto inicial',
                contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                isDense: true,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time_outlined)),
            onTap: () async {
              var time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());

              if (time != null) {
                setState(() {
                  timeStartController.text =
                      formatterTime(DateTime(1, 1, 1, time.hour, time.minute));
                });
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: timeEndController,
              readOnly: true,
              validator: (value) {
                if (!EventFormHelpers.isTimeValid(_startController,
                    timeStartController, _endController, timeEndController)) {
                  return 'El horario final debe ser mayor al inicial';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: '(*) Seleccionar hora/minuto final',
                  contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                  isDense: true,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time_outlined)),
              onTap: () async {
                var time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time != null) {
                  setState(() {
                    timeEndController.text = formatterTime(
                        DateTime(1, 1, 1, time.hour, time.minute));
                  });
                }
              }),
          const SizedBox(height: 20),
          CustomTextField(
            label: '(*) Fecha de inicio',
            controller: _startController,
            onTap: () async {
              final newDate = await showDatePicker(
                context: context,
                initialDate: _selectedDateStart,
                firstDate: DateTime(2010, 1, 1),
                lastDate: DateTime(DateTime.now().year + 5),
                fieldLabelText: 'Ingresar Fecha',
                locale: const Locale('es', 'ES'),
              );
              if (newDate != null) {
                setState(() {
                  _selectedDateStart = newDate;
                  _startController.text = formatterDate(newDate);
                  if (_selectedDateEnd.isBefore(_selectedDateStart)) {
                    _selectedDateEnd = _selectedDateStart;
                    _endController.text = formatterDate(_selectedDateEnd);
                    showToast(
                      context: context,
                      message: 'Se cambió la fecha de fin',
                      isNotification: true,
                    );
                  }
                  validateInputs();
                });
              }
            },
            readOnly: true,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: _endController,
            label: '(*) Fecha de fin',
            onTap: () async {
              final newDate = await showDatePicker(
                context: context,
                initialDate: _selectedDateEnd,
                firstDate: _selectedDateStart,
                lastDate: DateTime(DateTime.now().year + 5),
                fieldLabelText: 'Ingresar Fecha',
                locale: const Locale('es', 'ES'),
              );
              if (newDate != null) {
                setState(() {
                  _selectedDateEnd = newDate;
                  _endController.text = formatterDate(newDate);
                  validateInputs();
                });
              }
            },
          ),
          const SizedBox(height: 30),
          Text(
            'Seleccionar servicios de pagos',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkBoxNetworking,
                onChanged: (value) {
                  setState(() {
                    checkBoxNetworking = value!;
                  });
                },
              ),
              const Text('Networking'),
            ],
          ),
          const SizedBox(height: 2.5),
          Row(
            children: <Widget>[
              Checkbox(
                value: checkBoxTicket,
                onChanged: (value) {
                  setState(() {
                    checkBoxTicket = value!;
                  });
                },
              ),
              const Text('Ticket'),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Seleccionar zona horaria',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: "UTC: Tiempo universal coordinado",
                child: Icon(
                  Icons.help_outline,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
              "El horario del evento se establecerá según la zona horaria seleccionada.",
              style: TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          WidgetUtcSelector(
              listEvents: _listUtc,
              onEventSelected: (utcSelected) {
                utcController.text = utcSelected;
              }),
          const SizedBox(height: 20),
          Text(
            'Seleccionar idioma del evento',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            },
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: 'es',
                child: Text('Español (es)'),
              ),
              DropdownMenuItem<String>(
                value: 'en',
                child: Text('English (en)'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: buttonEnabled &&
                    EventFormHelpers.isTimeValid(_startController,
                        timeStartController, _endController, timeEndController)
                ? () async {
                    BlocProvider.of<CreateEventBloc>(context).add(SentData(
                        createEventModel: CreateEventModel(
                          eveName: nameController.text,
                          eveDescription: descriptionController.text,
                          eveAddress: addressController?.text,
                          eveSubtitle: subtitleController?.text,
                          siteWeb: siteWebController?.text,
                          eveAdditionalInfo: additionalInfoController?.text,
                          eveUrlMap: ubicationController?.text,
                          eveLatitude: latitudeController?.text,
                          eveLongitude: longitudeController?.text,
                          eveIcon: await encodeImageFile(iconController?.text),
                          eveLogo: await encodeImageFile(logoController?.text),
                          evePhoto:
                              await encodeImageFile(photoController?.text),
                          eveStart: EventFormHelpers.getDateTimeComplete(
                              _startController, timeStartController),
                          eveEnd: EventFormHelpers.getDateTimeComplete(
                              _endController, timeEndController),
                          eveNetworking: checkBoxNetworking,
                          eveTicket: checkBoxTicket,
                        ),
                        newSettingEvent: SettingEventModel(
                            estLanguage: selectedLanguage,
                            estTimeZone: utcController.text))); //38
                  }
                : null,
            child: BlocBuilder<CreateEventBloc, CreateEventState>(
              builder: (context, state) {
                if (state is CreateEventLoading) {
                  return const CupertinoActivityIndicator(
                    color: Colors.white,
                  );
                }
                return const Text('Crear Evento');
              },
            ),
          ),
        ],
      ),
    );
  }
}
