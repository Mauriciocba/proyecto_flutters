import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/gallery_create/domain/entities/gallery_create_model.dart';
import 'package:pamphlets_management/features/gallery_create/presentation/bloc/gallery_create_bloc.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../utils/common/custom_elevate_button.dart';

class GalleryCreateWidget extends StatefulWidget {
  final int _eventId;
  const GalleryCreateWidget({super.key, required int eventId})
      : _eventId = eventId;

  @override
  State<GalleryCreateWidget> createState() => _GalleryCreateWidgetState();
}

class _GalleryCreateWidgetState extends State<GalleryCreateWidget> {
  UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _newImage = TextEditingController();

  @override
  void dispose() {
    _newImage.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "* Cargue una Imagen ",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            WidgetImagePickerButton(
              key: _widgetUniqueKey,
              onImageSelected: (path) {
                _newImage.text = path;
              },
            ),
            const Tooltip(
              message: 'Imagen para la galería',
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: CustomTextButton(
                  label: const Text("Guardar"),
                  expanded: false,
                  onPressed: () => galleryCreate(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> encodeImageFile(String? imageUrl) async {
    if (imageUrl == null) {
      return '';
    }

    final response = await html.HttpRequest.request(
      imageUrl,
      responseType: 'blob',
    );

    final reader = html.FileReader();
    reader.readAsDataUrl(response.response as html.Blob);
    await reader.onLoad.first;

    final result = reader.result as String;

    List<String> resultSplit = result.split(',');

    final String resultOk = resultSplit[1].trim();

    return resultOk;
  }

  void galleryCreate(BuildContext context) async {
    if (_newImage.text.isEmpty) {
      return null;
    }
    BlocProvider.of<GalleryCreateBloc>(context).add(GalleryCreateStart(
        galleryCreate: GalleryCreateModel(
            galImage: await encodeImageFile(_newImage.text),
            eveId: widget._eventId)));

    resetTextFields();
  }

  void resetTextFields() {
    _formKey.currentState!.reset();
    setState(() {
      _widgetUniqueKey = UniqueKey();
      _newImage.clear();
    });
  }
}
