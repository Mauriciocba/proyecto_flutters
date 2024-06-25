import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class WidgetHeaderImage extends StatelessWidget {
  const WidgetHeaderImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    Uint8List? imageDecode;

    try {
      if (image.isEmpty) throw Exception();
      imageDecode = base64Decode(image);
    } catch (_) {
      debugPrint("No se pudo decodificar");
    }

    if (imageDecode != null) {
      return FadeInImage(
        width: double.infinity,
        height: double.infinity,
        placeholder: const AssetImage('assets/loading_cupertino_small.gif'),
        placeholderFit: BoxFit.cover,
        image: MemoryImage(imageDecode),
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          log(stackTrace.toString());
          return const SizedBox();
        },
      );
    }

    return const SizedBox();
  }
}
