import 'package:flutter/material.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

class FaqImagesList extends StatelessWidget {
  const FaqImagesList({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return _FaqImageItemList(imagePath: images[index]);
        },
      ),
    );
  }
}

class _FaqImageItemList extends StatelessWidget {
  final String imagePath;

  const _FaqImageItemList({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: WidgetImageLoader(
        image: imagePath,
        iconErrorLoad: const Icon(Icons.image_not_supported_outlined),
      ),
    );
  }
}
