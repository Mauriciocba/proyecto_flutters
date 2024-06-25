import 'package:flutter/material.dart';

class PasswordCustomTextField extends StatefulWidget {
  final String label;
  final Widget? prefix;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hint;

  const PasswordCustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefix,
    this.controller,
    this.validator,
  });

  @override
  State<PasswordCustomTextField> createState() =>
      _PasswordCustomTextFieldState();
}

class _PasswordCustomTextFieldState extends State<PasswordCustomTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            child: TextFormField(
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: widget.hint,
                contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                isDense: true,
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300)),
                prefixIcon: widget.prefix,
                suffixIcon: IconButton(
                  icon: hidePassword
                      ? const Icon(
                          Icons.visibility_off_outlined,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                        ),
                  onPressed: () {
                    setState(
                      () {
                        hidePassword = !hidePassword;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
