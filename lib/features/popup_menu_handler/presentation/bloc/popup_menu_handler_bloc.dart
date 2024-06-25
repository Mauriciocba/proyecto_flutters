import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popup_menu_handler_event.dart';
part 'popup_menu_handler_state.dart';

enum PopupMenuItemsGroup { events, event, activity, speakers, users }

enum PopupMenuItemType { download }

List<PopupMenuItemGroupDownload> itemsGroupAndLabel = [
  PopupMenuItemGroupDownload(
      value: PopupMenuItemsGroup.activity, label: 'Actividad'),
  PopupMenuItemGroupDownload(
      value: PopupMenuItemsGroup.speakers, label: 'Speakers'),
  PopupMenuItemGroupDownload(
      value: PopupMenuItemsGroup.users, label: 'Usuarios'),
];

class PopupMenuItems {
  final Widget child;
  final String typeLabel;

  final PopupMenuItemType popupMenuItemType;

  PopupMenuItems(
      {required this.child,
      required this.popupMenuItemType,
      required this.typeLabel});
}

class PopupMenuItemGroupDownload {
  final PopupMenuItemsGroup value;
  final String label;

  PopupMenuItemGroupDownload({
    required this.value,
    required this.label,
  });
}

class PopupMenuHandlerBloc
    extends Bloc<PopupMenuHandlerEvent, PopupMenuHandlerState> {
  PopupMenuHandlerBloc() : super(PopupMenuHandlerInitial()) {
    on<PopupMenuHandlerLoaderEvent>(_onPopupMenuHandlerLoaderEvent);
  }

  FutureOr<void> _onPopupMenuHandlerLoaderEvent(
      PopupMenuHandlerLoaderEvent event, Emitter<PopupMenuHandlerState> emit) {
    emit(PopupMenuHandlerLoaded(
        listPopupMenuItem: getMenuItems(event.popupMenuItemsGroup)));
  }
}

List<PopupMenuItems> getMenuItems(PopupMenuItemsGroup popupMenuItemsGroup) {
  switch (popupMenuItemsGroup) {
    case PopupMenuItemsGroup.events:
      return [
        PopupMenuItems(
            child:
                const Text('Descargar archivo', style: TextStyle(fontSize: 15)),
            typeLabel: 'eventos',
            popupMenuItemType: PopupMenuItemType.download),
      ];
    case PopupMenuItemsGroup.activity:
      return [
        PopupMenuItems(
            child:
                const Text('Descargar archivo', style: TextStyle(fontSize: 15)),
            typeLabel: 'actividades',
            popupMenuItemType: PopupMenuItemType.download)
      ];
    case PopupMenuItemsGroup.speakers:
      return [
        PopupMenuItems(
            child:
                const Text('Descargar archivo', style: TextStyle(fontSize: 15)),
            typeLabel: 'speacker',
            popupMenuItemType: PopupMenuItemType.download)
      ];
    case PopupMenuItemsGroup.users:
      return [
        PopupMenuItems(
            child:
                const Text('Descargar archivo', style: TextStyle(fontSize: 15)),
            typeLabel: 'usuarios',
            popupMenuItemType: PopupMenuItemType.download)
      ];
    case PopupMenuItemsGroup.event:
      return [
        PopupMenuItems(
            child:
                const Text('Descargar archivo', style: TextStyle(fontSize: 15)),
            typeLabel: 'usuarios',
            popupMenuItemType: PopupMenuItemType.download)
      ];
    default:
      return [];
  }
}
