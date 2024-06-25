import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/stand_delete/presentation/bloc/delete_stands_bloc.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/presentation/page/edit_stand_page.dart';
import 'package:pamphlets_management/features/stand_info/domain/entities/stands_info_model.dart';
import 'package:pamphlets_management/features/stand_info/presentation/bloc/info_stands_bloc.dart';
import 'package:pamphlets_management/features/stand_info/presentation/widgets/widget_social_media.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

class ListStandsWidget extends StatelessWidget {
  final List<StandsInfoModel> listStands;
  final int eventId;
  const ListStandsWidget(
      {super.key, required this.eventId, required this.listStands});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listStands.map((standsInfo) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _StandsInfoItemListCard(
              eventId: eventId,
              standsInfo: standsInfo,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StandsInfoItemListCard extends StatefulWidget {
  const _StandsInfoItemListCard({
    required this.eventId,
    required this.standsInfo,
  });

  final int eventId;
  final StandsInfoModel standsInfo;

  @override
  State<_StandsInfoItemListCard> createState() =>
      _StandsInfoItemListCardState();
}

class _StandsInfoItemListCardState extends State<_StandsInfoItemListCard>
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
        child: Card(
          elevation: _showActions ? 4 : 1,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Tooltip(
                  message: 'Foto Stand',
                  child: ClipOval(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: WidgetImageLoader(
                        image: widget.standsInfo.stdLogo,
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
                      RichText(
                        text: TextSpan(
                          text: '${widget.standsInfo.stdName.toUpperCase()} ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontFamily: 'Ubuntu',
                          ),
                          children: [
                            TextSpan(
                              text: ' Stand N° ${widget.standsInfo.stdNumber}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.standsInfo.stdNameCompany,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          )),
                      const SizedBox(height: 10),
                      Text(
                        widget.standsInfo.stdDescription,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            overflow: TextOverflow.ellipsis,
                            fontStyle: FontStyle.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.standsInfo.stdReferent,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade700,
                            overflow: TextOverflow.ellipsis,
                            fontStyle: FontStyle.normal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.standsInfo.stdStartup
                          ? Row(
                              children: [
                                Icon(Icons.storefront,
                                    size: 20,
                                    color: Colors.deepPurple.shade600),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text('STARTUP',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromARGB(221, 20, 20, 20),
                                      )),
                                )
                              ],
                            )
                          : const SizedBox(),

                      widget.standsInfo.web.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Wrap(
                                  spacing: 1.8,
                                  runSpacing: 1.8,
                                  children:
                                      widget.standsInfo.web.map((standsWeb) {
                                    return WidgetSocialMedia(
                                        name: standsWeb.asName!,
                                        url: standsWeb.asUrl);
                                  }).toList()),
                            )
                          : const SizedBox(),

                      // const Padding(
                      //   padding: EdgeInsets.only(top: 15),
                      //   child: Wrap(
                      //   spacing: 1.8,
                      //   runSpacing: 1.8,
                      //   children: [
                      //     WidgetSocialMedia(
                      //       name: 'Facebook',
                      //       url: 'www.facebook.com',
                      //     ),
                      //     WidgetSocialMedia(
                      //       name: 'Instagram',
                      //       url: 'www.ig.com',
                      //     ),
                      //   ],
                      // ),
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Tooltip(
                              message: 'Editar Stand',
                              child: IconButton(
                                hoverColor: Colors.white,
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditStandsPage(
                                                  standModel: StandsEditModel(
                                                      stdId: widget
                                                          .standsInfo.stdId,
                                                      stdName:
                                                          widget.standsInfo.stdName,
                                                      stdNameCompany: widget
                                                          .standsInfo
                                                          .stdNameCompany,
                                                      stdDescription: widget
                                                          .standsInfo
                                                          .stdDescription,
                                                      stdNumber: widget
                                                          .standsInfo.stdNumber,
                                                      stdReferent: widget
                                                          .standsInfo.stdReferent,
                                                      stdStartup: widget
                                                          .standsInfo.stdStartup,
                                                      stdLogo: widget.standsInfo.stdLogo))))
                                      .then((value) => context.read<InfoStandsBloc>()..add(InfoStandsStart(eventId: widget.eventId)));
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Tooltip(
                              message: 'Eliminar Stand',
                              child: IconButton(
                                hoverColor: Colors.white,
                                icon:
                                    const Icon(Icons.delete_forever, size: 20),
                                onPressed: () {
                                  _deleteStand(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ])),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> _deleteStand(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return CustomDialog(
          title: 'Eliminar Stand',
          description:
              '¿Esta seguro de eliminar este Stand? Presione \'eliminar\' para confirmar',
          confirmLabel: 'Eliminar',
          confirm: () {
            BlocProvider.of<DeleteStandsBloc>(context)
                .add(DeleteStandStart(stdId: widget.standsInfo.stdId));
          },
        );
      },
    );
  }
}
