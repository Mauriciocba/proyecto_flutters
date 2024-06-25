import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/accounts/presentation/page/accounts_page.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/activity_summary_panel.dart';
import 'package:pamphlets_management/features/delete_event/presentation/bloc/bloc/delete_event_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/pages/edit_event_page.dart';
import 'package:pamphlets_management/features/event_configuration/presentation/page/event_configuration_page.dart';
import 'package:pamphlets_management/features/faq/presentation/page/faq_page.dart';
import 'package:pamphlets_management/features/gallery_info.dart/presentation/page/gallery_info_page.dart';
import 'package:pamphlets_management/features/info_event/domain/entities/event.dart';
import 'package:pamphlets_management/features/info_event/presentation/bloc/bloc/info_event_bloc.dart';
import 'package:pamphlets_management/features/news_info/presentation/page/news_info_page.dart';
import 'package:pamphlets_management/features/speakers_info/presentation/pages/speakers_info_page.dart';
import 'package:pamphlets_management/features/sponsors_info/presentation/page/sponsors_info_page.dart';
import 'package:pamphlets_management/features/stand_info/presentation/page/info_stands_page.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/common/date_format.dart';

class DetailEvent extends StatelessWidget with Toaster {
  final Event event;
  const DetailEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ActivitySummaryPage(
                            eventId: event.eveId, eventName: event.eveName),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.format_list_bulleted_outlined,
                    size: 16,
                  ),
                  label: const Text("Actividades"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SpeakersInfoPage(
                                  eventId: event.eveId,
                                  eventName: event.eveName,
                                )));
                  },
                  icon: const Icon(
                    Icons.co_present_outlined,
                    size: 16.0,
                  ),
                  label: const Text("Speakers"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AccountsPage(event.eveId, event.eveName),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.supervised_user_circle_outlined,
                    size: 16.0,
                  ),
                  label: const Text("Usuarios"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsInfoPage(eventId: event.eveId),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.newspaper,
                    size: 16.0,
                  ),
                  label: const Text("Noticias"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GalleryInfoPage(eventId: event.eveId),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.perm_media,
                    size: 16.0,
                  ),
                  label: const Text("Galería"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StandsInfoPage(eventId: event.eveId),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.storefront,
                    size: 16.0,
                  ),
                  label: const Text("Stands"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SponsorsInfoPage(eventId: event.eveId),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.campaign,
                    size: 16.0,
                  ),
                  label: const Text("Sponsors"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FaqPage(
                          eventId: event.eveId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.question_answer_outlined,
                    size: 16.0,
                  ),
                  label: const Text("FAQ"),
                ),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            EventConfigurationPage(eventId: event.eveId),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 16.0,
                  ),
                  label: const Text("Configuración"),
                ),
              ],
            ),
          ),
          const Divider(height: 0.5),
          Padding(
              padding: const EdgeInsets.all(24.0),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Wrap(
                        children: <Widget>[
                          Tooltip(
                            message: "Portada",
                            child: Card(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: WidgetImageLoader(
                                  image: event.evePhoto!,
                                  iconErrorLoad: const Icon(Icons.image),
                                ),
                              ),
                            ),
                          ),
                          Tooltip(
                            message: 'Logo',
                            child: Card(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: WidgetImageLoader(
                                  image: event.eveLogo!,
                                  iconErrorLoad: const Icon(Icons.image),
                                ),
                              ),
                            ),
                          ),
                          Tooltip(
                            message: 'Icono',
                            child: Card(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: WidgetImageLoader(
                                  image: event.eveIcon!,
                                  iconErrorLoad: const Icon(Icons.image),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: '${event.eveName.toUpperCase()} ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Ubuntu',
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Evento N° ${event.eveId}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text(
                              "Subtítulo",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            (event.eveSubtitle!.isNotEmpty)
                                ? Text('${event.eveSubtitle}')
                                : const Text("No contiene Subtitulo"),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Descripción del evento.",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              event.eveDescription,
                              maxLines: 3,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Información Adicional.",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            (event.eveAdditionalInfo!.isEmpty)
                                ? const Text(
                                    "No contiene información adicional")
                                : Text(
                                    event.eveAdditionalInfo!,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey),
                                  )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "DETALLES COMPLEMENTARIOS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text(
                              "Link del evento.",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            (event.eveUrl!.isNotEmpty)
                                ? InkWell(
                                    onTap: () {
                                      _goLinkSocialMedia(
                                          context, event.eveUrl!);
                                    },
                                    child: Text(
                                      '${event.eveUrl}',
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const Text("No contiene Url de evento."),
                            const SizedBox(height: 20),
                            const Text(
                              "Dirección del evento.",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                (event.eveAddress!.isNotEmpty)
                                    ? Text('${event.eveAddress}')
                                    : const Text("No contiene Dirección")
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.public,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                (event.eveUrlMap!.isNotEmpty)
                                    ? InkWell(
                                        onTap: () {
                                          _goLinkSocialMedia(
                                              context, event.eveUrlMap!);
                                        },
                                        child: Text(
                                          '${event.eveUrlMap}',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        "No contiene url de Google maps")
                              ],
                            ),
                            const SizedBox(height: 25),
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Inicio ${formatterDate(event.eveStart)}'),
                                const SizedBox(width: 10),
                                const Icon(Icons.calendar_month, size: 15),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text('Finaliza ${formatterDate(event.eveEnd)}'),
                              ],
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditEventPage(
                                      eventId: event.eveId,
                                    ),
                                  ))
                              .then((value) => context
                                  .read<InfoEventBloc>()
                                  .add(InfoEventStart(eventId: event.eveId)));
                        },
                        child: const Text("EDITAR"),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext contextDialog) {
                                return CustomDialog(
                                  title: 'Ventana de confirmación',
                                  description:
                                      '¿Está seguro de eliminar este evento?',
                                  confirmLabel: 'Eliminar',
                                  confirm: () {
                                    BlocProvider.of<DeleteEventBloc>(context)
                                        .add(DeleteEvent(eventId: event.eveId));
                                    BlocProvider.of<InfoEventBloc>(context)
                                        .add(DeletedEvent());
                                  },
                                );
                              });
                        },
                        child: const Text("ELIMINAR"),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _goLinkSocialMedia(context, String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, webOnlyWindowName: '_blank');
    } else {
      showToast(
          context: context,
          message: 'No se pudo acceder al link $url',
          isError: true);
    }
  }
}
