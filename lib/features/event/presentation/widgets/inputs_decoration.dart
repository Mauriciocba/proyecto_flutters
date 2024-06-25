import 'package:flutter/material.dart';

typedef ChangePasswordVisibilityFunction = void Function(bool);

class InputDecorations {
  static InputDecoration authInputDecorations({
    required String labelText,
    bool? disabledBorder,
    bool? enabledBorder,
    String? errorText,
    IconData? prefixIcon,
    bool? visibilityPassword,
    bool isDateTimeSelect = false,
    ChangePasswordVisibilityFunction? changePasswordVisibility,
  }) {
    return const InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
      isDense: true,
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.access_time_outlined),
    );
  }
}
