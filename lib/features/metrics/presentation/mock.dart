import 'package:flutter/material.dart';

class Metric {
  final String title;
  final Icon iconData;

  Metric({
    required this.title,
    required this.iconData,
  });
}

List<Metric> metricsList = [
  Metric(
    title: 'Logins',
    iconData: const Icon(
      Icons.person_2_outlined,
      size: 16,
    ),
  ),
  Metric(
    title: 'Pagos',
    iconData: const Icon(
      Icons.payment_outlined,
      size: 16,
    ),
  ),
  Metric(
    title: 'Actividades',
    iconData: const Icon(Icons.format_list_bulleted_outlined),
  ),
];
