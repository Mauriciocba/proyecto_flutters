import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/news_delete/presentation/bloc/bloc/delete_news_bloc.dart';
import 'package:pamphlets_management/features/news_info/domain/entities/news_model.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsList extends StatelessWidget {
  final List<NewsModel> listNews;
  final int eventId;
  const NewsList({super.key, required this.eventId, required this.listNews});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listNews.map((newsInfo) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _NewsInfoItemListCard(
              eventId: eventId,
              newsInfo: newsInfo,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NewsInfoItemListCard extends StatefulWidget {
  const _NewsInfoItemListCard({
    required this.eventId,
    required this.newsInfo,
  });

  final int eventId;
  final NewsModel newsInfo;

  @override
  State<_NewsInfoItemListCard> createState() => _NewsInfoItemListCardState();
}

class _NewsInfoItemListCardState extends State<_NewsInfoItemListCard>
    with Toaster {
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        setState(() {
          _showActions = false;
        });
      },
      onEnter: (_) {
        setState(() {
          _showActions = true;
        });
      },
      child: SizedBox(
        width: 900,
        child: Card(
          elevation: _showActions ? 4 : 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: WidgetImageLoader(
                      image: widget.newsInfo.newImage ?? '',
                      iconErrorLoad: const Icon(Icons.image),
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 1.0,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: widget.newsInfo.newArticle
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: " ${widget.newsInfo.newArticle.substring(1)}",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${widget.newsInfo.newCreatedAt}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (widget.newsInfo.newUrl != null)
                  InkWell(
                    onTap: () {
                      _goLinkSocialMedia(context, widget.newsInfo.newUrl!);
                    },
                    child: Text(
                      'Leer más',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Tooltip(
                    message: 'Eliminar Articulo',
                    child: IconButton(
                      icon: const Icon(Icons.delete_forever, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) {
                            return CustomDialog(
                              title: 'Eliminar Articulo',
                              description:
                                  '¿Esta seguro de eliminar este Articulo? Presione \'eliminar\' para confirmar',
                              confirmLabel: 'Eliminar',
                              confirm: () {
                                BlocProvider.of<DeleteNewsBloc>(context).add(
                                    DeleteNews(newsId: widget.newsInfo.newId));
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
