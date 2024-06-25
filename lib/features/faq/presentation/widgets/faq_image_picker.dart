import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FaqImagePicker extends StatefulWidget {
  final List<String> imageUrl;
  const FaqImagePicker(this.imageUrl, {super.key});

  @override
  State<FaqImagePicker> createState() => _FaqImagePickerState();
}

class _FaqImagePickerState extends State<FaqImagePicker> {
  final int _MAX_IMAGES_ALLOWED = 5;
  final int _IMAGE_QUALITY_PERCENTAGE = 80;
  final double _MAX_IMAGE_WIDTH = 320;

  bool isAllowUploadImage = true;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 4,
      runSpacing: 4,
      children: [
        SizedBox(
          height: 100,
          width: 120,
          child: OutlinedButton(
            onPressed: isAllowUploadImage ? _pickImage : null,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_search_rounded),
                Text('Agregar'),
              ],
            ),
          ),
        ),
        ...List.generate(
          widget.imageUrl.length,
          (index) => _FaqImageItem(
            imageUri: widget.imageUrl[index],
            onTap: () => _removeImage(index),
          ),
        ),
      ],
    );
  }

  void _pickImage() async {
    XFile? selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: _IMAGE_QUALITY_PERCENTAGE,
      maxWidth: _MAX_IMAGE_WIDTH,
    );

    if (selectedImage != null) {
      final pickedImage = PickedFile(selectedImage.path);

      setState(() {
        widget.imageUrl.add(pickedImage.path);
        isAllowUploadImage = widget.imageUrl.length < _MAX_IMAGES_ALLOWED;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      widget.imageUrl.removeAt(index);
      isAllowUploadImage = widget.imageUrl.length < _MAX_IMAGES_ALLOWED;
    });
  }
}

class _FaqImageItem extends StatefulWidget {
  final String imageUri;
  final void Function() onTap;
  const _FaqImageItem({required this.imageUri, required this.onTap});

  @override
  State<_FaqImageItem> createState() => _FaqImageItemState();
}

class _FaqImageItemState extends State<_FaqImageItem> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: InkWell(
        onTap: _isHover ? widget.onTap : null,
        child: Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            // color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: _buildImage(),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: _isHover
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withOpacity(0.4),
                )
              : null,
          child: _isHover
              ? const Icon(Icons.close_rounded, color: Colors.white)
              : null,
        ),
      ),
    );
  }

  ImageProvider _buildImage() {
    try {
      final decodedImage = base64Decode(widget.imageUri);
      return MemoryImage(decodedImage);
    } catch (_) {
      return NetworkImage(widget.imageUri);
    }
  }

  void _onEnter(event) {
    setState(() {
      _isHover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _isHover = false;
    });
  }
}
