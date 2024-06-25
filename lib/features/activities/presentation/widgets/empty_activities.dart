import 'package:flutter/material.dart';

import 'package:pamphlets_management/features/activities/presentation/page/new_activity_page.dart';

class EmptyActivities extends StatelessWidget {
  final int _selectedEventId;

  const EmptyActivities({super.key, required int selectedEventId})
      : _selectedEventId = selectedEventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text("No contiene actividades"),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NewActivityPage(eventId: _selectedEventId),
                ),
              );
            },
            child: const Text("Crear actividad"))
      ],
    );
  }
}
