import 'package:flutter/material.dart';

class PanelItem extends StatefulWidget {
  final String _title;
  final IconData _icon;
  final void Function() _onSelect;
  final bool _isSelect;

  const PanelItem({
    super.key,
    required void Function() onSelectMetric,
    required bool isSelected,
    required String title,
    required IconData icon,
  })  : _icon = icon,
        _title = title,
        _onSelect = onSelectMetric,
        _isSelect = isSelected;

  @override
  State<PanelItem> createState() => _PanelItemState();
}

class _PanelItemState extends State<PanelItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        onTap: widget._onSelect,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        dense: true,
        selectedTileColor: colorTheme.primary.withOpacity(0.1),
        selected: widget._isSelect,
        leading: Icon(
          // Icons.bar_chart,
          widget._icon,
          size: 20,
        ),
        trailing: widget._isSelect
            ? const Icon(Icons.keyboard_arrow_right_rounded)
            : null,
        title: Text(
          widget._title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: widget._isSelect ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
