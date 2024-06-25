import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/gallery_delete/presentation/bloc/gallery_delete_bloc.dart';
import 'package:pamphlets_management/features/gallery_info.dart/domain/entities/gallery_model.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

class ListGalleryInfoWidget extends StatelessWidget {
  final List<GalleryModel> gallery;
  final int eventId;
  const ListGalleryInfoWidget(
      {super.key, required this.eventId, required this.gallery});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0,
        runSpacing: 8.0,
        children: gallery.map((galleryInfo) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _GalleryInfoItemListCard(
              eventId: eventId,
              gallery: galleryInfo,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GalleryInfoItemListCard extends StatefulWidget {
  const _GalleryInfoItemListCard({
    required this.eventId,
    required this.gallery,
  });

  final int eventId;
  final GalleryModel gallery;

  @override
  State<_GalleryInfoItemListCard> createState() =>
      _GalleryInfoItemListCardState();
}

class _GalleryInfoItemListCardState extends State<_GalleryInfoItemListCard>
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
        height: 300,
        width: 300,
        child: Card(
          elevation: _showActions ? 4 : 1,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 230,
                  width: 250,
                  child: WidgetImageLoader(
                    image: widget.gallery.galImage,
                    iconErrorLoad: const Icon(Icons.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete_forever_outlined, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) {
                            return CustomDialog(
                              title: 'Eliminar Imagen',
                              description:
                                  '¿Esta seguro de eliminar esta Imagen? Presione \'eliminar\' para confirmar',
                              confirmLabel: 'Eliminar',
                              confirm: () {
                                BlocProvider.of<GalleryDeleteBloc>(context).add(
                                  DeleteGallery(
                                      galleryId: widget.gallery.galId),
                                );
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
}
