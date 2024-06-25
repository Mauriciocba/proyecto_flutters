import 'package:flutter/material.dart';

void showPanelDialog(BuildContext context, Widget dialogWidget) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.6,
        child: dialogWidget,
      ),
    ),
  );
}
