import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:pamphlets_management/features/activities/presentation/page/activity_detail_page.dart';
import 'package:pamphlets_management/features/activities/presentation/page/edit_activity_page.dart';
import 'package:pamphlets_management/features/activity/delete_activity/presentation/bloc/delete_activity_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/tag.dart';

class ActivitySummaryCard extends StatefulWidget {
  final int eventId;
  final Activity activity;

  const ActivitySummaryCard({
    super.key,
    required this.eventId,
    required this.activity,
  });

  @override
  State<ActivitySummaryCard> createState() => _ActivitySummaryCardState();
}

class _ActivitySummaryCardState extends State<ActivitySummaryCard> {
  bool showActions = false;

  void _showDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ActivityDetailPage(activity: widget.activity)),
    ).then(
      (_) => context.read<ActivitiesBloc>().add(
          RequestedActivities(eventId: widget.eventId, page: 1, limit: 10)),
    );
  }

  void _showEditActivityPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditActivityPage(activity: widget.activity),
      ),
    ).then(
      (_) => context.read<ActivitiesBloc>().add(
          RequestedActivities(eventId: widget.eventId, page: 1, limit: 10)),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return CustomDialog(
          title: "¿Desea eliminar esta actividad?",
          description: "Presiona \"Eliminar\" para confirmar su eliminación.",
          confirmLabel: 'Eliminar',
          confirm: () {
            context
                .read<DeleteActivityBloc>()
                .add(DeleteActivity(activityId: widget.activity.activityId));
          },
        );
      },
    ).then(
      (_) => context.read<ActivitiesBloc>().add(
          RequestedActivities(eventId: widget.eventId, page: 1, limit: 10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        setState(() {
          showActions = false;
        });
      },
      onEnter: (_) {
        setState(() {
          showActions = true;
        });
      },
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => _showDetails(context),
        child: Card(
          elevation: showActions ? 4 : 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      widget.activity.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500),
                    ),
                    if (showActions)
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.deepPurple,
                        size: 20.0,
                      ),
                    const Spacer(),
                    if (showActions)
                      IconButton(
                        onPressed: () => _showEditActivityPage(context),
                        tooltip: "Editar",
                        icon: const Icon(Icons.edit_note, size: 20),
                      ),
                    if (showActions)
                      IconButton(
                        onPressed: () => _showDeleteDialog(context),
                        tooltip: "Eliminar",
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          size: 20,
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.activity.description}",
                            textAlign: TextAlign.justify,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(height: 24.0),
                          if (widget.activity.category != null)
                            Tag(
                              label: widget.activity.category!.name,
                              description:
                                  widget.activity.category!.description,
                              icon: widget.activity.category!.iconName,
                              colorCode: widget.activity.category!.color,
                            ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Horario de inicio",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(formatterDate(widget.activity.start)),
                          Text(formatterTime(widget.activity.start)),
                          const SizedBox(height: 24.0),
                          if (widget.activity.speakers != null &&
                              widget.activity.speakers!.isNotEmpty)
                            _SpeakerCount(
                                count: widget.activity.speakers!.length),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Horario de finalización",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(formatterDate(widget.activity.end)),
                          Text(formatterTime(widget.activity.end)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpeakerCount extends StatelessWidget {
  const _SpeakerCount({
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _AvatarGroup(),
        const SizedBox(width: 14),
        Text(
          "$count Speakers",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}

class _AvatarGroup extends StatelessWidget {
  const _AvatarGroup();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.filled(
          3,
          Align(
            widthFactor: 0.3,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.deepPurple,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
