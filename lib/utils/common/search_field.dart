import 'package:flutter/material.dart';

typedef SearchCallback = void Function(
    {required BuildContext context, required int page, required String query});

class SearchField extends StatefulWidget {
  final SearchCallback _onSearchSubmit;
  const SearchField({
    super.key,
    required SearchCallback onSearchSubmit,
  }) : _onSearchSubmit = onSearchSubmit;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  _SearchFieldState();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onSubmitted() {
      widget._onSearchSubmit(
          context: context, page: 1, query: _searchController.text);

      setState(() {
        _isSearching = !_isSearching;
      });
    }

    return TextFormField(
      onFieldSubmitted: (valor) {
        if (valor.isNotEmpty) {
          onSubmitted();
        }
      },
      onChanged: (valor) {
        if (valor.isEmpty) {
          onSubmitted();
        }
      },
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        hintText: "Buscar",
        alignLabelWithHint: true,
        prefixIcon: const Icon(
          Icons.search,
        ),
        suffixIcon: _isSearching
            ? IconButton(
                onPressed: () {
                  _searchController.value = TextEditingValue.empty;
                  onSubmitted();
                },
                icon: const Icon(Icons.highlight_remove_rounded),
              )
            : TextButton(
                onPressed: () => onSubmitted(),
                child: const Text("Buscar"),
              ),
      ),
    );
  }
}
