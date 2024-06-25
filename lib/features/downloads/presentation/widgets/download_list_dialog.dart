import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/downloads/presentation/bloc/download_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';

class DownloadCheckboxListDialog extends StatefulWidget {
  final List<PopupMenuItemGroupDownload> selectedItems = [];
  final List<PopupMenuItemGroupDownload> items;
  final void Function(List<PopupMenuItemGroupDownload>) confirm;
  DownloadCheckboxListDialog(
      {super.key, required this.items, required this.confirm});

  @override
  State<DownloadCheckboxListDialog> createState() =>
      _DownloadCheckboxListDialogState();
}

class _DownloadCheckboxListDialogState
    extends State<DownloadCheckboxListDialog> {
  late List<PopupMenuItemGroupDownload> _selectedItems = [];
  @override
  void initState() {
    _selectedItems = widget.selectedItems;
    super.initState();
  }

  void _itemChange(PopupMenuItemGroupDownload item, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(item);
      } else {
        _selectedItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadBloc(GetIt.instance.get(),
          GetIt.instance.get(), GetIt.instance.get(), GetIt.instance.get()),
      child: BlocBuilder<DownloadBloc, DownloadState>(
        builder: (context, state) {
          if (state is DownloadInitial) {
            return AlertDialog(
              title: Text('Seleccione para descargar archivos en formato excel',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListBody(
                      children: widget.items
                          .map((item) => CheckboxListTile(
                              value: _selectedItems.contains(item),
                              title: Text(item.label,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (isChecked) =>
                                  _itemChange(item, isChecked!)))
                          .toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: widget.selectedItems.isEmpty
                      ? null
                      : () {
                          widget.confirm(widget.selectedItems);
                        },
                  child: const Text('Descargar'),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
