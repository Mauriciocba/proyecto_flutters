import 'package:flutter/material.dart';

class FilterDropDown extends StatelessWidget {
  final List<SelectableItem> _items;
  final void Function(int? value)? _onSelect;

  const FilterDropDown({
    super.key,
    required List<SelectableItem> items,
    required void Function(int?)? onSelect,
  })  : _onSelect = onSelect,
        _items = items;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      expandedInsets: const EdgeInsets.all(0),
      hintText: "Buscar speaker",
      leadingIcon: const Icon(Icons.search_rounded),
      enableFilter: true,
      enableSearch: true,
      onSelected: _onSelect,
      dropdownMenuEntries: List.generate(
        _items.length,
        (index) {
          return DropdownMenuEntry(
            enabled: !_items[index].isSelected,
            value: _items[index].value,
            label: _items[index].label,
          );
        },
      ),
    );
  }
}

abstract class SelectableItem {
  int get value;
  String get label;
  String get description;
  bool isSelected = false;
}

class SpeakerItem extends SelectableItem {
  final int _speakerId;
  final String _firstName;
  final String _lastName;
  final String _description;
  final String? _image;

  SpeakerItem({
    required int speakerId,
    required String firstName,
    required String lastName,
    required String description,
    String? image,
  })  : _speakerId = speakerId,
        _firstName = firstName,
        _lastName = lastName,
        _description = description,
        _image = image;

  @override
  String get label => "$_lastName, $_firstName";

  @override
  String get description => _description;

  @override
  int get value => _speakerId;

  String? get image => _image;
}
