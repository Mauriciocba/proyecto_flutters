import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_delete/presentation/bloc/sponsors_delete_bloc.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/page/edit_sponsors_page.dart';
import 'package:pamphlets_management/features/sponsors_info/domain/entities/sponsors_info_model.dart';
import 'package:pamphlets_management/features/sponsors_info/presentation/bloc/info_sponsors_bloc.dart';
import 'package:pamphlets_management/features/sponsors_info/presentation/widgets/widget_social_media.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

class ListSponsorsWidget extends StatelessWidget {
  final List<Sponsor> listSponsors;
  final int eventId;
  const ListSponsorsWidget(
      {super.key, required this.eventId, required this.listSponsors});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0,
        runSpacing: 8.0,
        children: listSponsors.map((sponsorsInfo) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _SponsorsInfoItemListCard(
              eventId: eventId,
              sponsorsInfo: sponsorsInfo,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SponsorsInfoItemListCard extends StatefulWidget {
  const _SponsorsInfoItemListCard({
    required this.eventId,
    required this.sponsorsInfo,
  });

  final int eventId;
  final Sponsor sponsorsInfo;

  @override
  State<_SponsorsInfoItemListCard> createState() =>
      _SponsorsInfoItemListCardState();
}

class _SponsorsInfoItemListCardState extends State<_SponsorsInfoItemListCard>
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
        width: 450,
        child: Card(
          elevation: _showActions ? 4 : 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                const SizedBox(height: 8),
                Tooltip(
                  message: 'Foto Sponsor',
                  child: ClipOval(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: WidgetImageLoader(
                        image: widget.sponsorsInfo.spoLogo,
                        iconErrorLoad: const Icon(Icons.image),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  height: 80.0,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          widget.sponsorsInfo.spoName.toUpperCase(),
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Ubuntu',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Text(
                          widget.sponsorsInfo.spoDescription,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              overflow: TextOverflow.ellipsis,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          widget.sponsorsInfo.spoUrl!.isNotEmpty
                              ? WidgetUrl(
                                  name: 'Ir al sitio',
                                  url: widget.sponsorsInfo.spoUrl!)
                              : const SizedBox(),
                          const SizedBox(
                            width: 80,
                          ),
                          if (widget.sponsorsInfo.spcName != null)
                            Expanded(
                              child: Container(
                                height: 30,
                                width: 50,
                                color: const Color.fromARGB(255, 120, 51, 210),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                      widget.sponsorsInfo.spcName!
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Tooltip(
                                message: 'Editar Sponsor',
                                child: IconButton(
                                  hoverColor: Colors.white,
                                  icon: const Icon(Icons.edit, size: 20),
                                  onPressed: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EditSponsorsPage(
                                                    eventId: widget.eventId,
                                                    sponsorEditModel: SponsorsEditModel(
                                                        spcName: widget
                                                            .sponsorsInfo.spcName,
                                                        spoId: widget
                                                            .sponsorsInfo.spoId,
                                                        eveId: widget.eventId,
                                                        spcId: widget
                                                            .sponsorsInfo.spcId,
                                                        spoName: widget
                                                            .sponsorsInfo.spoName,
                                                        spoDescription: widget
                                                            .sponsorsInfo
                                                            .spoDescription,
                                                        spoLogo: widget
                                                            .sponsorsInfo.spoLogo,
                                                        spoUrl: widget.sponsorsInfo.spoUrl!))))
                                        .then((value) => context.read<InfoSponsorsBloc>()..add(InfoSponsorsStart(eventId: widget.eventId)));
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Tooltip(
                                message: 'Eliminar Sponsor',
                                child: IconButton(
                                  hoverColor: Colors.white,
                                  icon: const Icon(Icons.delete_forever,
                                      size: 20),
                                  onPressed: () {
                                    _deleteSponsor(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _deleteSponsor(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return CustomDialog(
          title: 'Eliminar Sponsor',
          description:
              '¿Esta seguro de eliminar este Sponsor? Presione \'eliminar\' para confirmar',
          confirmLabel: 'Eliminar',
          confirm: () {
            BlocProvider.of<SponsorsDeleteBloc>(context)
                .add(DeleteSponsorsStart(spoId: widget.sponsorsInfo.spoId));
          },
        );
      },
    );
  }
}
