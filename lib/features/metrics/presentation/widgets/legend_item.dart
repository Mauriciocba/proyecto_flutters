import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
