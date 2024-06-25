part of 'popup_menu_handler_bloc.dart';

sealed class PopupMenuHandlerEvent {}

class PopupMenuHandlerLoaderEvent implements PopupMenuHandlerEvent {
  final PopupMenuItemsGroup popupMenuItemsGroup;
  const PopupMenuHandlerLoaderEvent({required this.popupMenuItemsGroup});
}
