import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/utils/event_form_helpers.dart';
import 'package:pamphlets_management/features/news_create/domain/entities/news_model.dart';
import 'package:pamphlets_management/features/news_create/presentation/bloc/news_bloc.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/date_textfield.dart';
import 'package:pamphlets_management/utils/common/time_textfield.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../utils/common/custom_elevate_button.dart';
import '../../../../utils/common/custom_textfield.dart';

class NewsWidget extends StatefulWidget {
  final int _eventId;
  const NewsWidget({super.key, required int eventId}) : _eventId = eventId;

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _newArticle = TextEditingController();
  final TextEditingController _newCreatedAt = TextEditingController();
  final TextEditingController _newUrl = TextEditingController();
  final TextEditingController _newImage = TextEditingController();
  final TextEditingController _startTime = TextEditingController();

  @override
  void dispose() {
    _newArticle.dispose();
    _newCreatedAt.dispose();
    _newUrl.dispose();
    _newImage.dispose();
    _startTime.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _newCreatedAt.text = formatterDate(DateTime.now());
    _startTime.text = formatterTime(DateTime.now());
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
              "Completa los siguientes datos para registrar una Noticia",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "* Datos obligatorios",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            WidgetImagePickerButton(
              key: _widgetUniqueKey,
              onImageSelected: (path) {
                _newImage.text = path;
              },
            ),
            const Tooltip(
              message: 'Imagen del Articulo',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Nombre del Articulo",
                    controller: _newArticle,
                    prefix: const Icon(Icons.article),
                    validator: (name) {
                      if (name == null || name == "" || name.trim().isEmpty) {
                        return "Debes completar el Nombre del Articulo";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: " Url Del Articulo",
                    controller: _newUrl,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (newsUrl) {
                      if (newsUrl!.trim().isEmpty) {
                        return "Debes agregar una link valido.";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DateTextField(
                    controller: _newCreatedAt,
                    label: "Fecha de creación",
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TimeEditText(
                    controller: _startTime,
                    label: "Hora de inicio",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: CustomTextButton(
                  label: const Text("Guardar"),
                  expanded: false,
                  onPressed: () => newsCreate(context),
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

  void newsCreate(BuildContext context) async {
    if (_newArticle.text.trim().isEmpty) {
      return null;
    }

    if (_newUrl.text.trim().isEmpty) {
      return null;
    }

    final startDateTime =
        EventFormHelpers.getDateTimeComplete(_newCreatedAt, _startTime);
    BlocProvider.of<NewsBloc>(context).add(NewsStart(
        news: NewsModel(
            newArticle: _newArticle.text,
            eveId: widget._eventId,
            newUrl: _newUrl.text,
            newImage: await encodeImageFile(_newImage.text),
            newCreatedAt: startDateTime)));

    resetTextFields();
  }

  void resetTextFields() {
    _formKey.currentState!.reset();
    setState(() {
      _widgetUniqueKey = UniqueKey();
    });
  }
}
