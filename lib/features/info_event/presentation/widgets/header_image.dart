import 'package:flutter/material.dart';

import 'package:pamphlets_management/features/info_event/presentation/widgets/widget_header_image.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
    required this.urlImage,
  });

  final String? urlImage;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(bottom: 40),
      height: 500.0,
      child: AspectRatio(
        aspectRatio: 1920 / 100, 
        child:WidgetHeaderImage(image: urlImage ?? ''),
        ),
      );
  }
}