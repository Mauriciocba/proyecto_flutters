import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/filter_picker_drop_down.dart';
import 'package:pamphlets_management/features/speakers/presentation/bloc/bloc/create_speaker_bloc.dart';
import 'package:pamphlets_management/features/speakers_info/presentation/bloc/speakers_info_bloc.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

class SpeakerPicker extends StatelessWidget {
  final int _eventId;
  final void Function(int) selectItem;
  final void Function(int) unSelectItem;
  const SpeakerPicker({
    super.key,
    required int eventId,
    required this.selectItem,
    required this.unSelectItem,
  }) : _eventId = eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpeakersInfoBloc(GetIt.instance.get())
        ..add(SpeakersOnStart(
            eventId: _eventId, page: null, limit: null, search: null)),
      child: BlocListener<CreateSpeakerBloc, CreateSpeakerState>(
        listener: (context, state) {
          if (state is CreateSpeakerSuccess) {
            BlocProvider.of<SpeakersInfoBloc>(context).add(SpeakersOnStart(
                eventId: _eventId, page: null, limit: null, search: null));
          }
        },
        child: BlocBuilder<SpeakersInfoBloc, SpeakersInfoState>(
          builder: (context, state) {
            if (state is SpeakersInfoSuccess) {
              return SpeakerFilterDropDown(
                selectItem: selectItem,
                unSelectItem: unSelectItem,
                speakers: state.listSpeakers
                    .map((e) => SpeakerItem(
                        speakerId: e.speId,
                        firstName: e.firstName,
                        lastName: e.lastName,
                        description: e.description,
                        image: e.photo))
                    .toList(),
              );
            }
            return const Text("Cargando lista");
          },
        ),
      ),
    );
  }
}

class SpeakerFilterDropDown extends StatefulWidget {
  final List<SpeakerItem> _speakers;
  final void Function(int) selectItem;
  final void Function(int) unSelectItem;

  const SpeakerFilterDropDown({
    super.key,
    required List<SpeakerItem> speakers,
    required this.selectItem,
    required this.unSelectItem,
  }) : _speakers = speakers;

  @override
  State<SpeakerFilterDropDown> createState() => _SpeakerFilterDropDownState();
}

class _SpeakerFilterDropDownState extends State<SpeakerFilterDropDown> {
  late final List<SpeakerItem> _items;

  @override
  void initState() {
    super.initState();
    _items = widget._speakers;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterDropDown(
            items: _items,
            onSelect: _selectSpeaker,
          ),
          const SizedBox(height: 16.0),
          Text(
            "Speakers asignados",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            children: _getSelectedSpeakers(),
          ),
        ],
      ),
    );
  }

  List<Widget> _getSelectedSpeakers() {
    var widgetListOfSelectedSpeakers = <Widget>[];
    for (var (index, speaker) in _items.indexed) {
      if (speaker.isSelected) {
        widgetListOfSelectedSpeakers.add(_SelectedSpeakerCard(
          speakerModel: speaker,
          onPressed: () => _unselectSpeaker(index),
        ));
      }
    }

    return widgetListOfSelectedSpeakers;
  }

  void _selectSpeaker(value) {
    final item = _items.firstWhere((element) => element.value == value);
    widget.selectItem(item.value);
    setState(() {
      item.isSelected = true;
    });
  }

  void _unselectSpeaker(int index) {
    setState(() {
      _items[index].isSelected = false;
      widget.unSelectItem(_items[index].value);
    });
  }
}

class _SelectedSpeakerCard extends StatelessWidget {
  const _SelectedSpeakerCard({
    required SpeakerItem speakerModel,
    required this.onPressed,
  }) : _speakerModel = speakerModel;

  final SpeakerItem _speakerModel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: WidgetImageLoader(
                      image: _speakerModel.image ?? "Sin imagen",
                      iconErrorLoad: const Icon(Icons.image),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _speakerModel.label,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _speakerModel.description,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: IconButton(
              splashRadius: 8,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: onPressed,
              icon: const Icon(
                Icons.close_rounded,
                size: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
