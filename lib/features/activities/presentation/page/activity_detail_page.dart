import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/domain/entities/speakers.dart';
import 'package:pamphlets_management/features/activities/presentation/page/edit_activity_page.dart';
import 'package:pamphlets_management/features/activity/delete_activity/presentation/bloc/delete_activity_bloc.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/tag.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailPage extends StatelessWidget with Toaster {
  final Activity _activity;

  const ActivityDetailPage({super.key, required Activity activity})
      : _activity = activity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteActivityBloc, DeleteActivityState>(
      listener: (context, state) {
        if (state is DeleteActivitySuccess) {
          showToast(context: context, message: "Eliminado");
          Navigator.of(context).pop();
        }
        if (state is DeleteActivityFailure) {
          showToast(
            context: context,
            message: "No se pudo eliminar",
            isError: true,
          );
        }
      },
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Detalle de actividad",
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.chevron_left_rounded),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Toolbar(_activity),
                const Divider(height: 0.5),
                _ActivityInfo(
                  activity: _activity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityInfo extends StatelessWidget {
  final Activity _activity;

  const _ActivityInfo({
    required Activity activity,
  }) : _activity = activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                _buildCategory(),
                _buildSubcategory(),
              ],
            ),
          ),
          Text(
            _activity.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32.0),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 400) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _activity.description ?? "-",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16.0),
                    _ImportantInfo(
                      initialDateTime:
                          "${formatterDate(_activity.start)} - ${formatterTime(_activity.start)}",
                      finishDateTime:
                          "${formatterDate(_activity.end)} - ${formatterTime(_activity.end)}",
                      location: _activity.location ?? "-",
                      isQuestionsActivated: _activity.actAsk,
                    ),
                    const SizedBox(width: 32.0),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        _activity.description ?? "-",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    _ImportantInfo(
                      initialDateTime:
                          "${formatterDate(_activity.start)} - ${formatterTime(_activity.start)}",
                      finishDateTime:
                          "${formatterDate(_activity.end)} - ${formatterTime(_activity.end)}",
                      location: _activity.location ?? "-",
                      isQuestionsActivated: _activity.actAsk,
                    ),
                    const SizedBox(width: 32.0),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32.0),
          Text(
            "Información Adicional",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey),
          ),
          const Divider(),
          const SizedBox(height: 8.0),
          _LinkForm(activity: _activity),
          const SizedBox(height: 32.0),
          Text(
            "Información de Speakers",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey),
          ),
          const Divider(),
          const SizedBox(height: 8.0),
          _ListSpeakers(speakers: _activity.speakers),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    if (_activity.category == null) return const SizedBox();

    return Tag(
      label: _activity.category!.name,
      description: _activity.category!.description,
      colorCode: _activity.category!.color,
      icon: _activity.category!.iconName,
    );
  }

  Widget _buildSubcategory() {
    if (_activity.category == null) return const SizedBox();
    if (_activity.category!.subCategory == null) return const SizedBox();

    return Tag(
      label: _activity.category!.subCategory!.name,
      description: _activity.category!.subCategory!.description,
      colorCode: _activity.category!.subCategory!.color,
      icon: _activity.category!.subCategory!.icon,
    );
  }
}

class _LinkForm extends StatelessWidget {
  const _LinkForm({
    required Activity activity,
  }) : _activity = activity;

  final Activity _activity;

  @override
  Widget build(BuildContext context) {
    if (_activity.urlForm == null || _activity.urlForm!.isEmpty) {
      return const Text(
        "No tiene formulario asociado",
        style: TextStyle(color: Colors.black87),
      );
    }
    return ListTile(
      onTap: () async {
        if (_activity.urlForm != null) {
          await launchUrl(Uri.parse(_activity.urlForm!));
        }
      },
      dense: true,
      leading: const Icon(Icons.link, size: 20.0),
      minLeadingWidth: 24.0,
      contentPadding: EdgeInsets.zero,
      title: Text(_activity.urlForm ?? 'Sin formulario'),
    );
  }
}

class _ListSpeakers extends StatelessWidget {
  final Iterable<Speaker>? _speakers;

  const _ListSpeakers({Iterable<Speaker>? speakers}) : _speakers = speakers;

  @override
  Widget build(BuildContext context) {
    if (_speakers == null || _speakers.isEmpty) {
      return const Text(
        "No tiene speakers asignados",
        style: TextStyle(color: Colors.black87),
      );
    }
    return Column(
      children: _speakers
          .map(
            (e) => ListTile(
              leading: const Icon(Icons.person_outlined, size: 20.0),
              dense: true,
              minLeadingWidth: 24.0,
              contentPadding: EdgeInsets.zero,
              title: Text("${e.lastName}, ${e.name}"),
            ),
          )
          .toList(),
    );
  }
}

class _ImportantInfo extends StatelessWidget {
  final String initialDateTime;
  final String finishDateTime;
  final String location;
  final bool isQuestionsActivated; //CONSULTAR POR NOMBRE A PONER

  const _ImportantInfo(
      {required this.initialDateTime,
      required this.finishDateTime,
      required this.location,
      required this.isQuestionsActivated});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300.0, minWidth: 50.0),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RowInfoWithIcon(
                label: "Inicia",
                icon: Icons.calendar_month_outlined,
                value: initialDateTime,
                isColorActivated: false,
              ),
              const SizedBox(height: 8),
              _RowInfoWithIcon(
                label: "Finaliza",
                icon: Icons.calendar_month_outlined,
                value: finishDateTime,
                isColorActivated: false,
              ),
              const SizedBox(height: 8),
              _RowInfoWithIcon(
                label: "Ubicación",
                icon: Icons.pin_drop_outlined,
                value: location,
                isColorActivated: false,
              ),
              const SizedBox(height: 8),
              _RowInfoWithIcon(
                label: "Preguntas en la presentación",
                icon: Icons.chat_outlined,
                isColorActivated: true,
                color: isQuestionsActivated ? Colors.green : Colors.grey,
                value: isQuestionsActivated
                    ? 'Preguntas habilitadas'
                    : 'Preguntas inhabilitadas',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowInfoWithIcon extends StatelessWidget {
  final String _value;
  final IconData _icon;
  final String _label;
  final bool isColorActivated;
  final Color _color;

  const _RowInfoWithIcon({
    required String value,
    required IconData icon,
    required String label,
    required this.isColorActivated,
    Color color = Colors.black,
  })  : _value = value,
        _icon = icon,
        _label = label,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BorderedCircularIcon(
          icon: _icon,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: _CustomTileTwoValues(
            title: _label,
            value: _value,
            useColor: isColorActivated,
            color: _color,
          ),
        ),
      ],
    );
  }
}

class _CustomTileTwoValues extends StatelessWidget {
  final String _title;
  final String _value;
  final bool _useColor;
  final Color _color;

  const _CustomTileTwoValues({
    required String title,
    required String value,
    required bool useColor,
    Color color = Colors.black,
  })  : _title = title,
        _value = value,
        _useColor = useColor,
        _color = color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Colors.grey),
        ),
        Text(
          _value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: _useColor ? _color : null,
              ),
        )
      ],
    );
  }
}

class _BorderedCircularIcon extends StatelessWidget {
  final IconData _icon;

  const _BorderedCircularIcon({
    required IconData icon,
  }) : _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: Icon(
        _icon,
        color: Colors.grey,
        size: 16.0,
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  final Activity _activity;
  const _Toolbar(this._activity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditActivityPage(
                    activity: _activity,
                  ),
                ),
              );
            },
            label: const Text("Editar"),
            icon: const Icon(
              Icons.edit,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          // TextButton.icon(
          //   onPressed: () {},
          //   label: const Text("Asignar Speaker"),
          //   icon: const Icon(
          //     Icons.co_present_outlined,
          //     size: 16,
          //   ),
          // ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () async => showDialog(
              context: context,
              builder: (ctx) {
                return CustomDialog(
                  title: "¿Desea eliminar esta actividad?",
                  description:
                      "Presiona \"Eliminar\" para confirmar su eliminación.",
                  confirmLabel: 'Eliminar',
                  confirm: () {
                    context
                        .read<DeleteActivityBloc>()
                        .add(DeleteActivity(activityId: _activity.activityId));
                  },
                );
              },
            ),
            label: const Text("Borrar"),
            icon: const Icon(
              Icons.delete_forever_outlined,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
