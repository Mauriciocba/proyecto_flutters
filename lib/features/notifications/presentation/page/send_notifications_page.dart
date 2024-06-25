import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/notifications/presentation/bloc/notifier_bloc.dart';
import 'package:pamphlets_management/features/notifications/presentation/widgets/notification_form.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class SendNotificationPage extends StatelessWidget with Toaster {
  final int eventId;

  const SendNotificationPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotifierBloc(GetIt.instance.get()),
      child: BlocListener<NotifierBloc, NotifierState>(
        listener: (_, state) {
          if (state is NotifierFailure) {
            showToast(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }

          if (state is NotifierSuccess) {
            showToast(context: context, message: state.message);
          }
        },
        child: Column(
          children: [
            const _Header(),
            const Divider(height: 1.0),
            Expanded(
              child: ListView(
                children: [
                  Image.asset(
                    'send_notification.jpg',
                    width: 100.0,
                    height: 100.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Comunica y alerta a todos los usuarios del evento',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                  NotificationForm(eventId: eventId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    var titleMedium2 = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Enviar notificación",
            style: titleMedium2?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            iconSize: 16,
            splashRadius: 20,
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
