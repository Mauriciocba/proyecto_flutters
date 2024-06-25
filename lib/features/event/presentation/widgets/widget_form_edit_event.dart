import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/domain/entities/event_update.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/edit_event_bloc.dart';
import 'package:pamphlets_management/features/location/presentation/widgets/input_address_suggestions.dart';

import '../../../../utils/common/custom_textfield.dart';
import '../../../../utils/common/date_format.dart';
import '../../../../utils/common/encode_image_file.dart';
import '../../../../utils/common/toaster.dart';
import '../utils/event_form_helpers.dart';
import 'widgets.dart';

class WidgetFormEditEvent extends StatefulWidget {
  const WidgetFormEditEvent({super.key, required this.eventLoaded});

  final Event eventLoaded;

  @override
  State<WidgetFormEditEvent> createState() => _WidgetFormEditEventState();
}

class _WidgetFormEditEventState extends State<WidgetFormEditEvent>
    with Toaster {
  TextEditingController? logoController = TextEditingController();
  TextEditingController? photoController = TextEditingController();
  TextEditingController? iconController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController? subtitleController = TextEditingController();
  TextEditingController? siteWebController = TextEditingController();
  TextEditingController? additionalInfoController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? ubicationController = TextEditingController();
  TextEditingController? latitudeController = TextEditingController();
  TextEditingController? longitudeController = TextEditingController();
  final TextEditingController timeStartController = TextEditingController();
  final TextEditingController timeEndController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  late DateTime _selectedDateStart;
  late DateTime _selectedDateEnd;
  bool isStartDateSelected = true;
  late bool checkBoxTicket;
  late bool checkBoxNetworking;
  bool buttonEnabled = true;

  @override
  void initState() {
    _selectedDateStart = widget.eventLoaded.eveStart;
    _selectedDateEnd = widget.eventLoaded.eveEnd;
    logoController = TextEditingController(text: widget.eventLoaded.eveLogo);
    photoController = TextEditingController(text: widget.eventLoaded.evePhoto);
    iconController = TextEditingController(text: widget.eventLoaded.eveIcon);
    nameController.text = widget.eventLoaded.eveName;
    descriptionController.text = widget.eventLoaded.eveDescription;
    subtitleController =
        TextEditingController(text: widget.eventLoaded.eveSubtitle);
    siteWebController = TextEditingController(text: widget.eventLoaded.eveUrl);
    additionalInfoController =
        TextEditingController(text: widget.eventLoaded.eveAdditionalInfo);
    addressController =
        TextEditingController(text: widget.eventLoaded.eveAddress);
    ubicationController =
        TextEditingController(text: widget.eventLoaded.eveUrlMap);
    _startController =
        TextEditingController(text: formatterDate(widget.eventLoaded.eveStart));
    _endController =
        TextEditingController(text: formatterDate(widget.eventLoaded.eveEnd));
    timeStartController.text = formatterTime(widget.eventLoaded.eveStart);
    timeEndController.text = formatterTime(widget.eventLoaded.eveEnd);
    checkBoxNetworking = widget.eventLoaded.eveNetworking ?? false;
    checkBoxTicket = widget.eventLoaded.eveTicket ?? false;
    super.initState();
  }

  bool validateInputs() {
    return nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  WidgetImagePickerButton(
                    image: widget.eventLoaded.eveLogo,
                    onImageSelected: (path) {
                      logoController!.text = path;
                    },
                  ),
                  const Text("Logo"),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  WidgetImagePickerButton(
                    image: widget.eventLoaded.evePhoto,
                    onImageSelected: (path) {
                      photoController!.text = path;
                    },
                  ),
                  const Text("Foto de portada"),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  WidgetImagePickerButton(
                    image: widget.eventLoaded.eveIcon,
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
                timeStartController.text =
                    formatterTime(DateTime(1, 1, 1, time.hour, time.minute));
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
                  timeEndController.text =
                      formatterTime(DateTime(1, 1, 1, time.hour, time.minute));
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
          ElevatedButton(
            onPressed: validateInputs()
                ? () async {
                    BlocProvider.of<EditEventBloc>(context)
                        .add(EditEventConfirm(
                            idEvent: widget.eventLoaded.eveId,
                            eventUpdate: EventUpdate(
                              eveName: nameController.text,
                              eveDescription: descriptionController.text,
                              eveStart: EventFormHelpers.getDateTimeComplete(
                                  _startController, timeStartController),
                              eveEnd: EventFormHelpers.getDateTimeComplete(
                                  _endController, timeEndController),
                              eveTicket: checkBoxTicket,
                              eveNetworking: checkBoxNetworking,
                              eveAdditionalInfo: additionalInfoController?.text,
                              eveAddress: addressController?.text,
                              eveIcon:
                                  await encodeImageFile(iconController?.text),
                              eveLogo:
                                  await encodeImageFile(logoController?.text),
                              evePhoto:
                                  await encodeImageFile(photoController?.text),
                              eveSubtitle: subtitleController?.text,
                              eveUrlMap: ubicationController?.text,
                              eveUrl: siteWebController?.text,
                            )));
                  }
                : null,
            child: const Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }
}
