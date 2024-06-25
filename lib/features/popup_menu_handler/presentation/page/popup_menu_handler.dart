import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/downloads/presentation/widgets/download_custome_dialog.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';

class PopupMenuHandler extends StatefulWidget {
  final PopupMenuItemsGroup popupMenuItemsGroup;
  final int? eventId;
  final String eventName;
  const PopupMenuHandler(
      {super.key,
      required this.popupMenuItemsGroup,
      required this.eventId,
      required this.eventName});

  @override
  State<StatefulWidget> createState() => _PopupMenuHandlerState();
}

class _PopupMenuHandlerState extends State<PopupMenuHandler> {
  late PopupMenuItemsGroup _popupMenuItemsGroup;
  late int? _eventId;
  late String _eventName;
  @override
  void initState() {
    _popupMenuItemsGroup = widget.popupMenuItemsGroup;
    _eventId = widget.eventId;
    _eventName = widget.eventName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopupMenuHandlerBloc()
        ..add(PopupMenuHandlerLoaderEvent(
            popupMenuItemsGroup: _popupMenuItemsGroup)),
      child: BlocBuilder<PopupMenuHandlerBloc, PopupMenuHandlerState>(
        builder: (context, state) {
          if (state is PopupMenuHandlerLoaded) {
            return PopupMenuButton(
                icon: const Icon(Icons.more_vert_outlined),
                itemBuilder: (BuildContext context) {
                  return state.listPopupMenuItem
                      .map((e) => PopupMenuItem(
                            child: e.child,
                            onTap: () =>
                                itemSelected(e.popupMenuItemType, e.typeLabel),
                          ))
                      .toList();
                });
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }

  void itemSelected(PopupMenuItemType popupMenuItemType, String typeLabel) {
    switch (popupMenuItemType) {
      case PopupMenuItemType.download:
        showDialog(
            context: context,
            builder: (_) {
              return DownloadCustomDialog(
                eventId: _eventId,
                eventName: _eventName,
                typeLabel: typeLabel,
                popupMenuItemsGroup: _popupMenuItemsGroup,
              );
            });

        break;
      default:
    }
  }
}
