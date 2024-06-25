import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/speakers_delete/presentation/bloc/delete_speaker_bloc.dart';
import 'package:pamphlets_management/features/speakers_edit/domain/entities/speaker_edit_model.dart';
import 'package:pamphlets_management/features/speakers_edit/presentation/page/edit_speaker_page.dart';
import 'package:pamphlets_management/features/speakers_info/domain/entities/speakers_info_model.dart';
import 'package:pamphlets_management/features/speakers_info/presentation/pages/speakers_info_page.dart';
import 'package:pamphlets_management/features/speakers_info/presentation/widgets/widget_social_media.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

import '../bloc/speakers_info_bloc.dart';

class SpeakersList extends StatelessWidget {
  final List<SpeakersModel> listSpeakers;
  final int eventId;

  const SpeakersList(
      {super.key, required this.eventId, required this.listSpeakers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listSpeakers.map((speaker) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _SpeakerItemListCard(
              eventId: eventId,
              speaker: speaker,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SpeakerItemListCard extends StatefulWidget {
  const _SpeakerItemListCard({
    required this.eventId,
    required this.speaker,
  });

  final int eventId;
  final SpeakersModel speaker;

  @override
  State<_SpeakerItemListCard> createState() => _SpeakerItemListCardState();
}

class _SpeakerItemListCardState extends State<_SpeakerItemListCard> {
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Tooltip(
                message: 'Foto Speaker',
                child: ClipOval(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: WidgetImageLoader(
                      image: widget.speaker.photo,
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
                    Text(
                      '${widget.speaker.firstName}, ${widget.speaker.lastName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.speaker.description,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                        spacing: 1.8,
                        runSpacing: 1.8,
                        children:
                            widget.speaker.socialMedia.map((listSocialMedia) {
                          return WidgetSocialMedia(
                              name: listSocialMedia.somName,
                              url: listSocialMedia.somUrl);
                        }).toList()),
                  ],
                ),
              ),
              if (_showActions)
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditSpeakerPage(
                            speakerModel: SpeakerEditModel(
                                speId: widget.speaker.speId,
                                eveId: widget.eventId,
                                speFirstName: widget.speaker.firstName,
                                speLastName: widget.speaker.lastName,
                                speDescription: widget.speaker.description,
                                spePhoto: widget.speaker.photo),
                          ),
                        ),
                      ).then(
                        (value) => context.read<SpeakersInfoBloc>().add(
                            SpeakersOnStart(
                                limit: SpeakersInfoPage.limitOfResultPerPage,
                                page: SpeakersInfoPage.initialPage,
                                search: null,
                                eventId: widget.eventId)),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 20)),
              if (_showActions)
                IconButton(
                  icon: const Icon(Icons.delete_forever_outlined, size: 20),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext contextDialog) {
                        return CustomDialog(
                          title: 'Eliminar Speaker',
                          description:
                              '¿Esta seguro de eliminar este speaker? Presione \'eliminar\' para confirmar',
                          confirmLabel: 'Eliminar',
                          confirm: () {
                            BlocProvider.of<DeleteSpeakerBloc>(context).add(
                              DeleteSpeaker(speakerId: widget.speaker.speId),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
