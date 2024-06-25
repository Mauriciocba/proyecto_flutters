import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final String _currentPage;
  final VoidCallback _next;
  final VoidCallback _previous;

  const PaginationBar({
    super.key,
    required String currentPage,
    required void Function() next,
    required void Function() previous,
  })  : _next = next,
        _previous = previous,
        _currentPage = currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: _previous,
            child: const Icon(Icons.chevron_left_rounded),
          ),
          const SizedBox(width: 16.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 0.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(_currentPage),
          ),
          const SizedBox(width: 16.0),
          TextButton(
            onPressed: _next,
            child: const Icon(Icons.chevron_right_rounded),
          )
        ],
      ),
    );
  }
}
