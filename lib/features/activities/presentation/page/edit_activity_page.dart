import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/presentation/bloc/edit_activity_bloc/edit_activity_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_picker.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/date_textfield.dart';
import 'package:pamphlets_management/utils/common/tag.dart';
import 'package:pamphlets_management/utils/common/time_textfield.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class EditActivityPage extends StatelessWidget with Toaster {
  final Activity _activity;

  const EditActivityPage({super.key, required Activity activity})
      : _activity = activity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditActivityBloc(GetIt.instance.get()),
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Editar Actividad",
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
          child: BlocListener<EditActivityBloc, EditActivityState>(
            listener: (context, state) {
              if (state is EditActivitySuccess) {
                showToast(context: context, message: "Actividad actualizada");
                Navigator.of(context)
                  ..pop()
                  ..pop();
              }
              if (state is EditActivityFailure) {
                showToast(
                  context: context,
                  message: "No se pudo realizar los cambios",
                  isError: true,
                );
              }
              if (state is EditActivityLoadFailure) {
                showToast(
                  context: context,
                  message: "Hubo un problema, intente nuevamente",
                  isError: true,
                );
              }
            },
            child: BlocBuilder<EditActivityBloc, EditActivityState>(
              builder: (context, state) {
                if (state is EditActivityLoadInProgress) {
                  return const CupertinoActivityIndicator();
                }
                return _EditActivityForm(
                  activity: _activity,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EditActivityForm extends StatefulWidget {
  final Activity _activity;

  const _EditActivityForm({
    required Activity activity,
  }) : _activity = activity;

  @override
  State<_EditActivityForm> createState() => _EditActivityFormState();
}

class _EditActivityFormState extends State<_EditActivityForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkFormController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  late bool isQuestionsActivated;
  Category? _categorySelected;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget._activity.name;

    if (widget._activity.description != null) {
      _descriptionController.text = widget._activity.description!;
    }
    if (widget._activity.urlForm != null) {
      _linkFormController.text = widget._activity.urlForm ?? '';
    }

    if (widget._activity.location != null) {
      _locationController.text = widget._activity.location ?? '';
    }

    _startDateController.text = formatterDate(widget._activity.start);
    _startTimeController.text = formatterTime(widget._activity.start);
    _endDateController.text = formatterDate(widget._activity.end);
    _endTimeController.text = formatterTime(widget._activity.end);
    isQuestionsActivated = widget._activity.actAsk;

    _categorySelected = widget._activity.category;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifica la actividad y presiona en guardar para confirmar los cambios",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              label: "Título",
              controller: _titleController,
              prefix: const Icon(Icons.label_outline_rounded),
            ),
            CustomTextField(
              controller: _descriptionController,
              label: "Descripción",
              prefix: const Icon(Icons.label_outline_rounded),
            ),
            CustomTextField(
              controller: _linkFormController,
              label: "Link de formulario",
              prefix: const Icon(Icons.label_outline_rounded),
            ),
            CustomTextField(
              controller: _locationController,
              label: "Ubicación",
              prefix: const Icon(Icons.label_outline_rounded),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DateTextField(
                    controller: _startDateController,
                    label: "Fecha de inicio",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TimeEditText(
                    controller: _startTimeController,
                    label: "Hora de inicio",
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
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TimeEditText(
                    controller: _endTimeController,
                    label: "Hora de fin",
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
                  value: isQuestionsActivated,
                  onChanged: (value) {
                    setState(() {
                      isQuestionsActivated = value;
                    });
                  }),
              const SizedBox(
                width: 10,
              ),
              const Text(
                  "Poder hacer preguntas en la presentación del speaker."),
            ]),
            const SizedBox(height: 16),
            Row(
              children: [
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
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: CustomTextButton(
                label: const Text("Guardar"),
                expanded: false,
                onPressed: () {
                  final startDateTimeString =
                      "${_startDateController.text} - ${_startTimeController.text}";
                  final startDateTime = DateFormat("dd/mm/yyyy - hh:mm")
                      .parse(startDateTimeString);

                  final endDateTimeString =
                      "${_endDateController.text} - ${_endTimeController.text}";
                  final endDateTime =
                      DateFormat("dd/mm/yyyy - hh:mm").parse(endDateTimeString);

                  context.read<EditActivityBloc>().add(EditActivityConfirmed(
                        activityId: widget._activity.activityId,
                        activityFormData: (
                          name: _titleController.text,
                          description: _descriptionController.text,
                          urlForm: _linkFormController.text,
                          location: _locationController.text,
                          start: startDateTime,
                          end: endDateTime,
                          eventId: 0,
                          speakerIds: [],
                          categoryId: _categorySelected?.categoryId,
                          actAsk: isQuestionsActivated
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
