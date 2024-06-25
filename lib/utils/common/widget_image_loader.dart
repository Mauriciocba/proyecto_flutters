import 'dart:convert';

import 'package:flutter/cupertino.dart';

class WidgetImageLoader extends StatelessWidget {
  const WidgetImageLoader({
    super.key,
    required this.image,
    required this.iconErrorLoad,
    this.enabledFit = false,
  });

  final String image;
  final Icon iconErrorLoad;
  final bool enabledFit;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: const AssetImage(''),
      placeholderErrorBuilder: (context, error, stackTrace) {
        return const CupertinoActivityIndicator();
      },
      image: Image.memory(base64Decode(image)).image,
      fit: enabledFit ? BoxFit.cover : BoxFit.contain,
      imageErrorBuilder: (context, error, stackTrace) {
        return iconErrorLoad;
      },
    );
  }
}
