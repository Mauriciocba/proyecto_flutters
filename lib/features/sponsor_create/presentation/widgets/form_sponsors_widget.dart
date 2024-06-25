import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/widgets/category_sponsor_picker.dart';
import 'package:pamphlets_management/utils/common/tag.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/entities/sponsors_create_model.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/bloc/create_sponsors_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/widget_image_picker_button.dart';


class FormSponsorsWidget extends StatefulWidget {
  final int _eventId;
  const FormSponsorsWidget({super.key, required int eventId})
      : _eventId = eventId;

  @override
  State<FormSponsorsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<FormSponsorsWidget> {
  UniqueKey _widgetUniqueKey = UniqueKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _spo_name = TextEditingController();
  final TextEditingController _spo_description = TextEditingController();
  final TextEditingController _spo_url = TextEditingController();
  final TextEditingController _spo_logo = TextEditingController();
  SponsorsCategoryModel? _categorySelected;
  
  @override
  void dispose() {
    _spo_name.dispose();
    _spo_description.dispose();
    _spo_url.dispose();
    _spo_logo.dispose();
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
              "Completa los siguientes datos para registrar un Sponsor",
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "* Datos obligatorios",
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetImagePickerButton(
                  key: _widgetUniqueKey,
                  onImageSelected: (path) {
                    _spo_logo.text = path;
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "* Nombre del sponsor",
                    controller: _spo_name,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (name) {
                      if (name == null || name == "" || name.trim().isEmpty) {
                        return "Debes completar el Nombre del Sponsor";
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
                    label: "* Descripción del sponsor",
                    controller: _spo_description,
                    prefix: const Icon(Icons.label_outline_rounded),
                    validator: (descriptionCompany) {
                      if (descriptionCompany == null ||
                          descriptionCompany == "" ||
                          descriptionCompany.trim().isEmpty) {
                        return "Debes ingresar una descripción para sponsor";
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
                    label: "Link al sitio oficial",
                    controller: _spo_url,
                    prefix: const Icon(Icons.link_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
           Row(
              children: [
                Text(
                  "Categoría:",
                  textAlign: TextAlign.left,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16.0),
                if (_categorySelected != null)
                  Tag(
                    label: _categorySelected!.spcName!,
                    description: _categorySelected!.spcDescription,
                    isSmall: false,
                  ),
                if (_categorySelected != null)
                  IconButton.filled(
                    onPressed: () {
                      setState(() {
                        _categorySelected = null;
                      });
                    },
                    iconSize: 16.0,
                    splashRadius: 20.0,
                    icon: const Icon(Icons.close),
                  ),if (_categorySelected == null)
                  CategorySponsorPicker(
                    eventId: widget._eventId,
                    (category) {
                      setState(() {
                        _categorySelected = category;
                      });
                    },
                  )
              ],
            ),
            const SizedBox(height: 48),

            const SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: CustomTextButton(
                  label: BlocBuilder<CreateSponsorsBloc, CreateSponsorsState>(
                      builder: (context, state) {
                    if (state is CreateSponsorLoading) {
                      return const CupertinoActivityIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text("Guardar");
                  }),
                  expanded: false,
                  onPressed: () => SponsorCreate(context),
                ),
              ),
            ),
            BlocBuilder<CreateSponsorsBloc, CreateSponsorsState>(
              builder: (context, state) {
                if (state is CreateSponsorFailure) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(state.msgFail),
                  );
                }
                return const SizedBox();
              },
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

  void SponsorCreate(BuildContext context) async {
    if (_spo_name.text.trim().isEmpty) {
      return null;
    }

    if (_spo_description.text.trim().isEmpty) {
      return null;
    }

    BlocProvider.of<CreateSponsorsBloc>(context).add(SponsorsCreateStart(
        sponsorModel: SponsorsCreateModel(
            eveId: widget._eventId,
            spcId: _categorySelected?.spcId,
            spoName: _spo_name.text,
            spoDescription: _spo_description.text,
            spoLogo: await encodeImageFile(_spo_logo.text),
            spoUrl: _spo_url.text)));

    resetTextFields();
  }

  void resetTextFields() {
    _formKey.currentState!.reset();
    setState(() {
      _widgetUniqueKey = UniqueKey();
    });
  }
}
