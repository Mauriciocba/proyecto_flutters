import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/downloads/presentation/bloc/download_bloc.dart';
import 'package:pamphlets_management/features/downloads/presentation/widgets/download_list_dialog.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class DownloadCustomDialog extends StatelessWidget with Toaster {
  final PopupMenuItemsGroup popupMenuItemsGroup;
  final String typeLabel;
  final String eventName;
  final int? eventId;
  const DownloadCustomDialog(
      {super.key,
      required this.typeLabel,
      required this.popupMenuItemsGroup,
      required this.eventName,
      required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadBloc(GetIt.instance.get(),
          GetIt.instance.get(), GetIt.instance.get(), GetIt.instance.get()),
      child: BlocListener<DownloadBloc, DownloadState>(
        listener: (context, state) {
          switch (state) {
            case DownloadActivitiesFailure _:
              showError(context, state.errorMessage);
              break;
            case DownloadSpeakersFailure _:
              showError(context, state.errorMessage);
              break;
            case DownloadUsersFailure _:
              showError(context, state.errorMessage);
              break;
            case DownloadFinished _:
              Navigator.pop(context);
              break;
            default:
          }
        },
        child: BlocBuilder<DownloadBloc, DownloadState>(
          builder: (context, state) {
            switch (popupMenuItemsGroup) {
              case PopupMenuItemsGroup.event:
                return DownloadCheckboxListDialog(
                  items: itemsGroupAndLabel,
                  confirm: (itemsSelected) {
                    BlocProvider.of<DownloadBloc>(context).add(
                        RequestedDownloadEvent(
                            eventId: eventId,
                            eventName: eventName,
                            items: itemsSelected));
                  },
                );
              default:
                return CustomDialog(
                    title: 'Descargar archivo en formato excel',
                    description:
                        'Está por descargar archivo de información de $typeLabel en formato Excel. Para continuar, presione descargar, de lo contrario, cancelar.',
                    confirmLabel: 'Descargar',
                    confirm: () {
                      switch (popupMenuItemsGroup) {
                        case PopupMenuItemsGroup.events:
                          BlocProvider.of<DownloadBloc>(context)
                              .add(RequestedDownloadEvents());
                          break;

                        case PopupMenuItemsGroup.activity:
                          BlocProvider.of<DownloadBloc>(context).add(
                              RequestedDownloadActivity(
                                  eventId: eventId, eventName: eventName));
                          break;
                        case PopupMenuItemsGroup.speakers:
                          BlocProvider.of<DownloadBloc>(context).add(
                              RequestedDownloadSpeakers(
                                  eventId: eventId, eventName: eventName));
                          break;
                        case PopupMenuItemsGroup.users:
                          BlocProvider.of<DownloadBloc>(context).add(
                              RequestedDownloadUsers(
                                  eventId: eventId, eventName: eventName));
                          break;
                        default:
                      }
                    });
            }
          },
        ),
      ),
    );
  }

  void showError(BuildContext context, String msg) {
    showToast(
      context: context,
      message: msg,
      isError: true,
    );
  }
}
