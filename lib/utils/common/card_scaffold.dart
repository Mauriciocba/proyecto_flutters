import 'package:flutter/material.dart';

GlobalKey myKeyScaffold = GlobalKey();

class CardScaffold extends StatelessWidget {
  final CustomAppBar appBar;
  final Widget body;

  const CardScaffold({
    super.key,
    required this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          appBar,
          const Divider(height: 1.0),
          Expanded(
            child: body,
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        children: [
          leading ?? const SizedBox(),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          trailing ?? const SizedBox()
        ],
      ),
    );
  }
}
