import 'package:flutter/material.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WidgetUrl extends StatefulWidget {
  final String name;
  final String url;

  const WidgetUrl({super.key, required this.name, required this.url});

  @override
  WidgetUrlState createState() => WidgetUrlState();
}

class WidgetUrlState extends State<WidgetUrl> with Toaster {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isHovered
            ? const Color.fromARGB(255, 250, 205, 216)
            : const Color.fromRGBO(255, 231, 249, 1),
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
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 0, 0),
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
