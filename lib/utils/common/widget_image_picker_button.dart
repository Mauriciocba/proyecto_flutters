import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';
import 'package:universal_html/html.dart' as html;

class WidgetImagePickerButton extends StatefulWidget {
  final Function(String)? onImageSelected;
  final String? image;
  const WidgetImagePickerButton({super.key, this.onImageSelected, this.image});

  @override
  WidgetImagePickerButtonState createState() => WidgetImagePickerButtonState();
}

class WidgetImagePickerButtonState extends State<WidgetImagePickerButton> {
  PickedFile? pickedImage;

  void resetImage() {
    setState(() {
      pickedImage = null;
    });
  }

  Future<void> selectImage() async {
    if (kIsWeb) {
      html.FileUploadInputElement input = html.FileUploadInputElement()
        ..accept = 'image/*';
      input.click();

      input.onChange.listen((event) {
        if (input.files != null && input.files!.isNotEmpty) {
          final html.File file = input.files![0];
          final url = html.Url.createObjectUrlFromBlob(file);

          if (widget.onImageSelected != null) {
            widget.onImageSelected!(url);
          }

          setState(() {
            pickedImage = PickedFile(url);
          });
        }
      });
    } else {
      XFile? selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage =
          selectedImage != null ? PickedFile(selectedImage.path) : null;

      if (pickedImage == null) {
        debugPrint('No se seleccionó ninguna imagen');
        return;
      }

      debugPrint('Tenemos la imagen seleccionada: ${pickedImage!.path}');
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(pickedImage!.path);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomRight,
        children: [
          if (pickedImage != null)
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(pickedImage!.path),
                      fit: BoxFit.cover)),
            ),
          if (pickedImage == null)
            ClipOval(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: WidgetImageLoader(
                  image: widget.image ?? '',
                  iconErrorLoad: const Icon(Icons.add_a_photo),
                  enabledFit: true,
                ),
              ),
            ),
          pickedImage == null
              ? InkWell(
                  onTap: selectImage,
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Icon(
                      Icons.add_a_photo_sharp,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: resetImage,
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
