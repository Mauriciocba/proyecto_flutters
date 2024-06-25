import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String confirmLabel;
  final void Function() confirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    required this.confirmLabel,
    required this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(24.0),
      actionsPadding:
          const EdgeInsets.only(bottom: 16.0, right: 16.0, top: 8.0),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.error_outline_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text(confirmLabel),
          onPressed: () {
            confirm();
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
            side: MaterialStatePropertyAll(
              BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        )
      ],
    );
  }
}
