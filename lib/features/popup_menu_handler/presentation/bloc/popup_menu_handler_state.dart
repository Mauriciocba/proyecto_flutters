part of 'popup_menu_handler_bloc.dart';

sealed class PopupMenuHandlerState extends Equatable {
  const PopupMenuHandlerState();

  @override
  List<Object> get props => [];
}

final class PopupMenuHandlerInitial extends PopupMenuHandlerState {}

final class PopupMenuHandlerLoaded extends PopupMenuHandlerState {
  final List<PopupMenuItems> listPopupMenuItem;
  const PopupMenuHandlerLoaded({required this.listPopupMenuItem});
}

final class PopupMenuHandlerItemSelected extends PopupMenuHandlerState {
  final String itemSelected;
  const PopupMenuHandlerItemSelected({required this.itemSelected});
}
