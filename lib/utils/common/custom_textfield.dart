import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? Function(String?)? onChange;
  final bool readOnly;
  final String? tooltip;
  final bool? filled;
  final bool withInputLabel;
  final int? minLines;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.onTap,
    this.onChange,
    this.readOnly = false,
    this.tooltip,
    this.filled,
    this.withInputLabel = false,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !withInputLabel
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (label != null && !withInputLabel)
                Text(
                  label!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              const SizedBox(width: 8),
              if (tooltip != null)
                Tooltip(
                  message: tooltip!,
                  child: Icon(
                    Icons.help_outline,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            onChanged: onChange,
            readOnly: readOnly,
            onTap: onTap,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            minLines: minLines,
            maxLines: minLines ?? 1,
            decoration: InputDecoration(
              filled: filled,
              label: withInputLabel ? Text(label!) : null,
              contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              hintText: hint,
              isDense: true,
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              prefixIcon: prefix,
              suffixIcon: suffix,
            ),
          ),
        ],
      ),
    );
  }
}
