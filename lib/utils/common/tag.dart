import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String _label;
  final String? _icon;
  final String? _description;
  final String? _colorCode;
  final bool _isSmall;

  const Tag(
      {super.key,
      required String label,
      String? icon,
      String? description,
      String? colorCode,
      bool isSmall = true})
      : _label = label,
        _icon = icon,
        _description = description,
        _colorCode = colorCode,
        _isSmall = isSmall;

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Tooltip(
      message: _description ?? 'Sin descripción',
      waitDuration: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(
          vertical: _isSmall ? 4.0 : 8.0,
          horizontal: 8.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: _getIcon(),
              ),
            Text(
              _label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: _isSmall ? 10.0 : 14.0, color: color),
            ),
          ],
        ),
      ),
    );
  }

  Icon? _getIcon() {
    if (_icon == null) return null;
    try {
      return Icon(
        IconData(int.parse(_icon), fontFamily: "MaterialIcons"),
        color: _getColor(),
        size: 12,
      );
    } catch (e) {
      return null;
    }
  }

  Color _getColor() {
    try {
      if (_colorCode != null) {
        return Color(int.parse(_colorCode));
      }
      return Colors.primaries.last;
    } catch (_) {
      return Colors.primaries.last;
    }
  }
}
