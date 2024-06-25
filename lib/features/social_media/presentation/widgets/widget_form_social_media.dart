import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/social_media/domain/entities/social_media.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/styles/web_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/common/custom_elevate_button.dart';
import '../../../../utils/common/custom_textfield.dart';

class WidgetFormSocialMedia extends StatefulWidget {
  final TextEditingController? somName;
  final TextEditingController? somUrl;
  final List<SocialMediaModel> socialMediaList;
  const WidgetFormSocialMedia(
      {super.key,
      required this.somName,
      required this.somUrl,
      required this.socialMediaList});

  @override
  State<WidgetFormSocialMedia> createState() => _WidgetFormSocialMediaState();
}

class _WidgetFormSocialMediaState extends State<WidgetFormSocialMedia>
    with Toaster {
  @override
  void dispose() {
    widget.somName?.dispose();
    widget.somUrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: "Nombre de la red social",
            hint: 'Facebook',
            controller: widget.somName,
            prefix: const Icon(Icons.language),
          ),
          CustomTextField(
            label: "Link de la red social",
            hint: 'https://www.facebook.com/alan.romero.0000',
            controller: widget.somUrl,
            prefix: const Icon(Icons.alternate_email),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: CustomTextButton(
                  label: const Text('Agregar Red Social'),
                  expanded: false,
                  onPressed: () {
                    setState(() {
                      if ((widget.somName?.text.isNotEmpty ?? false) &&
                          (widget.somUrl?.text.isNotEmpty ?? false)) {
                        socialMediaAdd(
                            context,
                            SocialMediaModel(
                                somName: widget.somName?.text.trim(),
                                somUrl: widget.somUrl?.text.trim()));
                      } else {
                        showToast(
                            context: context,
                            message: 'Falta completar campos',
                            isError: true);
                      }
                    });
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.socialMediaList.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Redes Sociales Agregadas:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (var socialMedia in widget.socialMediaList)
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                      maxWidth: 600,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tileColor: WebTheme.getTheme().colorScheme.background,
                        leading: const Icon(
                          Icons.web_asset,
                          color: Colors.black,
                        ),
                        title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              '${socialMedia.somName}:',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  _goLinkSocialMedia(
                                      context, socialMedia.somUrl ?? '');
                                },
                                child: const Text('Ingresar al link asignado'))
                          ],
                        ),
                        trailing: IconButton.filled(
                          onPressed: () {
                            setState(() {
                              widget.socialMediaList.remove(socialMedia);
                            });
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  void socialMediaAdd(BuildContext context, SocialMediaModel socialMedia) {
    setState(() {
      widget.socialMediaList.add(socialMedia);
      showToast(context: context, message: 'Red social agregada');
      resetTextFields();
    });
  }

  void resetTextFields() {
    widget.somName?.clear();
    widget.somUrl?.clear();
  }

  void _goLinkSocialMedia(context, String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, webOnlyWindowName: '_blank');
    } else {
      showToast(
          context: context,
          message: 'No se pudo acceder al link $url',
          isError: true);
    }
  }
}
