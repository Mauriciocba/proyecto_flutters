import 'package:flutter/material.dart';

class Constants {
  static const headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  static const otpInputDecoration = InputDecoration(
      // contentPadding: const EdgeInsets.symmetric(vertical: 1),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 241, 241, 241));

  UnderlineInputBorder underlineInputBorder() {
    return const UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
