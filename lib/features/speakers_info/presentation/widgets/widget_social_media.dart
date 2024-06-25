import 'package:flutter/material.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetSocialMedia extends StatefulWidget {
  final String name;
  final String url;

  const WidgetSocialMedia({super.key, required this.name, required this.url});

  @override
  WidgetSocialMediaState createState() => WidgetSocialMediaState();
}

class WidgetSocialMediaState extends State<WidgetSocialMedia> with Toaster {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isHovered
            ? const Color.fromARGB(255, 83, 83, 83)
            : const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          _goLinkSocialMedia(context, widget.url);
        },
        onHover: (hovered) {
          setState(() {
            isHovered = hovered;
          });
        },
        child: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
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
