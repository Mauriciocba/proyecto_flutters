import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/delete_event/presentation/bloc/bloc/delete_event_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/pages/create_event_page.dart';
import 'package:pamphlets_management/features/info_event/presentation/bloc/bloc/info_event_bloc.dart';
import 'package:pamphlets_management/features/info_event/presentation/widgets/info_event_widget.dart';
import 'package:pamphlets_management/features/notifications/presentation/page/send_notifications_page.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/page/popup_menu_handler.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/panel_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class InfoEventPage extends StatefulWidget {
  const InfoEventPage({super.key});

  @override
  State<InfoEventPage> createState() => _InfoEventPageState();
}

class _InfoEventPageState extends State<InfoEventPage> with Toaster {
  late bool activeMenuOption = false;
  late int eventId = 0;
  late String eventName = '';
  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoEventBloc, InfoEventState>(
      listener: (context, state) {
        if (state is InfoEventSuccess) {
          setState(() {
            eventId = state.event.eveId;
            eventName = state.event.eveName;
          });
        }
      },
      child: BlocListener<EventAllBloc, EventAllState>(
        listener: (context, state) {
          switch (state) {
            case EventAllSuccess _:
              setState(() => activeMenuOption = true);
              break;
            case EventAllFailure _:
              setState(() => activeMenuOption = false);
              break;
            default:
          }
        },
        child: BlocListener<DeleteEventBloc, DeleteEventState>(
          listener: (innerContext, state) {
            if (state is FailureDeleteEvent) {
              showToast(
                  context: innerContext,
                  message: 'Hubo un Error',
                  isError: true);
            }
            if (state is SuccessDeleteEvent) {
              innerContext.read<EventAllBloc>().add(EventAllStart());
              showToast(context: innerContext, message: 'Evento eliminado');
            }
          },
          child: CardScaffold(
            appBar: CustomAppBar(
              title: "Información de Evento",
              trailing: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_box_outlined),
                    onPressed: _navigateToCreateEventPage,
                  ),
                  IconButton(
                      onPressed: () => showPanelDialog(
                            context,
                            SendNotificationPage(eventId: eventId),
                          ),
                      icon: const Icon(Icons.edit_notifications_rounded)),
                  if (activeMenuOption && eventId != 0) _buildPopupMenuHandler()
                ],
              ),
            ),
            body: const InfoEventWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenuHandler() {
    return PopupMenuHandler(
      key: UniqueKey(),
      popupMenuItemsGroup: PopupMenuItemsGroup.event,
      eventName: eventName,
      eventId: eventId,
    );
  }

  void _navigateToCreateEventPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CreateEventPage(),
      ),
    ).then(
      (shouldGoBack) {
        if (shouldGoBack != null && shouldGoBack) {
          context.read<EventAllBloc>().add(EventAllStart());
        }
      },
    );
  }
}
