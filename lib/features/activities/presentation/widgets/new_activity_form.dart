import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pamphlets_management/features/activities/presentation/bloc/new_activity_bloc/new_activity_bloc.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/speaker_picker.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_picker.dart';
import 'package:pamphlets_management/features/speakers/presentation/bloc/bloc/create_speaker_bloc.dart';
import 'package:pamphlets_management/features/speakers/presentation/widgets/new_speaker_form.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/date_textfield.dart';
import 'package:pamphlets_management/utils/common/tag.dart';
import 'package:pamphlets_management/utils/common/time_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class NewActivityForm extends StatefulWidget {
  final int _eventId;
  const NewActivityForm({super.key, required int eventId}) : _eventId = eventId;

  @override
  State<NewActivityForm> createState() => _NewActivityFormState();
}

class _NewActivityFormState extends State<NewActivityForm> with Toaster {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkFormController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final List<int> _selectedSpeakerIds = [];
  bool _isQuestionsActivated = false;
  Category? _categorySelected;

  bool _isNewSpeakerFormVisible = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkFormController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _startTimeController.dispose();
    _endDateController.dispose();
    _endTimeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startDateController.text = formatterDate(DateTime.now());
    _endDateController.text = formatterDate(DateTime.now());

    _startTimeController.text = formatterTime(DateTime.now());
    _endTimeController.text =
        formatterTime(DateTime.now().add(const Duration(minutes: 10)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocListener(
      listeners: [
        BlocListener<NewActivityBloc, NewActivityState>(
          listener: (context, state) {
            if (state is NewActivityRegisterSuccess) {
              _resetTextFields();
            }
          },
        ),
        BlocListener<CreateSpeakerBloc, CreateSpeakerState>(
          listener: (context, state) {
            if (state is CreateSpeakerSuccess) {
              showToast(
                  context: context, message: "Se registro el nuevo speaker");
            }
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Completa los siguientes datos para registrar una nueva actividad a tu evento",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "* Datos obligatorios",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: "* Título",
              controller: _titleController,
              prefix: const Icon(Icons.label_outline_rounded),
              validator: (title) {
                if (title == null || title == "" || title.trim().isEmpty) {
                  return "Debes completar el título de la actividad";
                }
                return null;
              },
            ),
            CustomTextField(
              label: "* Descripción",
              controller: _descriptionController,
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
            CustomTextField(
              label: "Link de formulario",
              tooltip: "Puedes agregar tus formularios web pegando el link",
              controller: _linkFormController,
              prefix: const Icon(Icons.link_outlined),
            ),
            CustomTextField(
              label: "Ubicación",
              tooltip: "Lugar presencial donde se lleva a cabo el evento",
              controller: _locationController,
              prefix: const Icon(Icons.location_on_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DateTextField(
                    controller: _startDateController,
                    label: "Fecha de inicio",
                    validator: _afterDateValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TimeEditText(
                    controller: _startTimeController,
                    label: "Hora de inicio",
                    validator: _afterTimeValidator,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DateTextField(
                    label: "Fecha de fin",
                    controller: _endDateController,
                    validator: _beforeDateTimeValidator,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TimeEditText(
                    controller: _endTimeController,
                    label: "Hora de fin",
                    initialTime: TimeOfDay.fromDateTime(
                        DateTime.now().add(const Duration(minutes: 10))),
                    validator: _beforeTimeValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(children: [
              const Text("Habilitar preguntas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Switch(
                  activeColor: const Color(0xFF7138FD),
                  activeTrackColor: const Color.fromARGB(255, 142, 102, 180),
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 5.0,
                  value: _isQuestionsActivated,
                  onChanged: (value) {
                    setState(() {
                      _isQuestionsActivated = value;
                    });
                  }),
              const SizedBox(
                width: 10,
              ),
              const Text(
                  "Poder hacer preguntas en la presentación del speaker."),
            ]),
            const SizedBox(height: 48),
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
                    label: _categorySelected!.name,
                    description: _categorySelected?.description,
                    colorCode: _categorySelected?.color,
                    icon: _categorySelected?.iconName,
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
                  CategoryPicker(
                    (category) {
                      context.pop();
                      setState(() {
                        _categorySelected = category;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Asignar speakers",
                      textAlign: TextAlign.left,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Tooltip(
                      message:
                          "Persona responsable de llevar a cabo o imponer una conferencia",
                      child: Icon(
                        Icons.help_outline,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  label: const Text("Nuevo speaker"),
                  icon: Icon(_isNewSpeakerFormVisible
                      ? Icons.arrow_drop_up_rounded
                      : Icons.arrow_drop_down_rounded),
                  onPressed: () => _showNewSpeakerForm(context),
                ),
              ],
            ),
            if (_isNewSpeakerFormVisible)
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0)),
                child: NewSpeakerForm(
                  eventId: widget._eventId,
                ),
              ),
            const SizedBox(height: 16.0),
            BlocBuilder<CreateSpeakerBloc, CreateSpeakerState>(
              builder: (context, state) {
                return SpeakerPicker(
                  eventId: widget._eventId,
                  selectItem: _selectSpeaker,
                  unSelectItem: _unselectSpeaker,
                );
              },
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: CustomTextButton(
                label: BlocBuilder<NewActivityBloc, NewActivityState>(
                  builder: (context, state) {
                    if (state is NewActivityRegisterLoading) {
                      return const CupertinoActivityIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text("Guardar");
                  },
                ),
                expanded: false,
                onPressed: () => _submitNewActivity(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _unselectSpeaker(int id) {
    setState(() {
      _selectedSpeakerIds.remove(id);
    });
  }

  void _selectSpeaker(int id) {
    setState(() {
      _selectedSpeakerIds.add(id);
    });
  }

  String? _afterTimeValidator(selectedTime) {
    if (selectedTime == null) {
      return "Debe seleccionar una hora";
    }
    final starTime = DateFormat("hh:mm").parse(selectedTime!);
    final endTime = DateFormat("hh:mm").parse(_endTimeController.text);

    if (starTime.isAfter(endTime)) {
      return "La hora debe ser posterior a la hora de fin";
    }

    return null;
  }

  String? _beforeTimeValidator(selectedTime) {
    if (selectedTime == null) {
      return "Debe seleccionar una hora";
    }
    final endTime = DateFormat("hh:mm").parse(selectedTime!);
    final starTime = DateFormat("hh:mm").parse(_startTimeController.text);
    final initialDate =
        DateFormat("dd/mm/yyyy").parse(_startDateController.text);
    final finishDate = DateFormat("dd/mm/yyyy").parse(_endDateController.text);

    if (initialDate.isAtSameMomentAs(finishDate) &&
        endTime.isBefore(starTime)) {
      return "La hora debe ser posterior a la hora de fin";
    }

    return null;
  }

  String? _beforeDateTimeValidator(selectedDateTime) {
    if (selectedDateTime == null) {
      return "Debe seleccionar una fecha";
    }
    final startDateTime =
        DateFormat("dd/mm/yyyy").parse(_startDateController.text);

    final endDateTime = DateFormat("dd/mm/yyyy").parse(selectedDateTime!);

    if (endDateTime.isBefore(startDateTime)) {
      return "Debe elegir una fecha posterior a la fecha inicio";
    }
    return null;
  }

  String? _afterDateValidator(selectedDateTime) {
    if (selectedDateTime == null) {
      return "Debe seleccionar una fecha";
    }
    final endDateTime = DateFormat("dd/mm/yyyy").parse(_endDateController.text);

    final startDateTime = DateFormat("dd/mm/yyyy").parse(selectedDateTime!);

    if (startDateTime.isAfter(endDateTime)) {
      return "Debe elegir una fecha anterior a la fecha de fin";
    }
    return null;
  }

  void _showNewSpeakerForm(BuildContext context) {
    setState(() {
      _isNewSpeakerFormVisible = !_isNewSpeakerFormVisible;
    });
  }

  void _submitNewActivity(BuildContext context) {
    final startDateTimeString =
        "${_startDateController.text} - ${_startTimeController.text}";
    final startDateTime =
        DateFormat("dd/mm/yyyy - hh:mm").parse(startDateTimeString);

    final endDateTimeString =
        "${_endDateController.text} - ${_endTimeController.text}";
    final endDateTime =
        DateFormat("dd/mm/yyyy - hh:mm").parse(endDateTimeString);

    BlocProvider.of<NewActivityBloc>(context).add(
      SubmittedNewActivity(
        dataInput: (
          name: _titleController.text,
          description: _descriptionController.text,
          location: _locationController.text,
          start: startDateTime,
          end: endDateTime,
          eventId: widget._eventId,
          urlForm: _linkFormController.text,
          speakerIds: _selectedSpeakerIds,
          categoryId: _categorySelected?.categoryId,
          actAsk: _isQuestionsActivated,
        ),
      ),
    );
  }

  void _resetTextFields() {
    _formKey.currentState?.reset();
  }
}
