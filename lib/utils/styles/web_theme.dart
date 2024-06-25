import 'package:flutter/material.dart';

import 'web_colors.dart';

class WebTheme {
  static ThemeData getTheme() {
    return ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: WebColors.primaryColorB,
          background: const Color.fromRGBO(244, 247, 246, 1),
          primary: WebColors.primaryColor,
          secondaryContainer: Colors.grey[300],
          tertiary: WebColors.secondaryColor,
        ),
        fontFamily: "Ubuntu",
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16.0),
          isDense: true,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: const MaterialStatePropertyAll(
            Colors.white,
          ),
          checkColor: const MaterialStatePropertyAll(
            WebColors.primaryColor,
          ),
        ),
        outlinedButtonTheme: const OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStatePropertyAll(
              BorderSide(
                color: WebColors.primaryColor,
              ),
            ),
          ),
        ));
  }
}
