import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Widget label;
  final void Function()? onPressed;
  final bool expanded;

  const CustomTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 42,
        width: expanded ? double.maxFinite : null,
        child: ElevatedButton(
          onPressed: onPressed,
          child: label,
        ),
      ),
    );
  }
}
