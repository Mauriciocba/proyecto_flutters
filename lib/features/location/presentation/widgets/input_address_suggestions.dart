import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/location/domain/entities/address_suggestion.dart';
import 'package:pamphlets_management/features/location/presentation/bloc/available_position_bloc.dart';
import 'package:pamphlets_management/features/location/presentation/bloc/suggestion_address_bloc.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';

class WidgetAddressSuggestions extends StatefulWidget {
  final void Function(String, String) onChangeLocation;
  final TextEditingController? addressController;
  const WidgetAddressSuggestions(
      {super.key,
      required this.onChangeLocation,
      required this.addressController});

  @override
  State<WidgetAddressSuggestions> createState() => AddressSuggestionsState();
}

class AddressSuggestionsState extends State<WidgetAddressSuggestions> {
  OverlayEntry? myOverlayEntry;
  late List<String> _suggestionsList = [];
  late AddressSuggestions _suggestions;
  List<double> coordinates = [];
  bool warningInput = false;
  Timer? _debounce;
  Size value = const Size(0, 0);
  final textControllerNetwork = TextEditingController();
  final SuggestionAddressBloc _suggestionAddressBloc =
      SuggestionAddressBloc(GetIt.instance.get(), GetIt.instance.get());
  final myKeyInputSuggestions = GlobalKey();
  var isVisible = false;
  late double maxWidth;

  void removeOverlayEntry() {
    if (myOverlayEntry != null) {
      myOverlayEntry!.remove();
      myOverlayEntry!.dispose();
      myOverlayEntry = null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PrimaryScrollController.of(context).addListener(repositionSuggestions);
  }

  void repositionSuggestions() {
    if (myOverlayEntry != null) {
      removeOverlayEntry();
    }
  }

  @override
  void dispose() {
    removeOverlayEntry();
    super.dispose();
  }

  void createOverlayEntry(BuildContext context) {
    value = MediaQuery.of(context).size;
    RenderBox renderBoxCardScaffold =
        myKeyScaffold.currentContext?.findRenderObject() as RenderBox;
    RenderBox renderBoxInput =
        myKeyInputSuggestions.currentContext?.findRenderObject() as RenderBox;
    Offset positionCardScaffold =
        renderBoxCardScaffold.localToGlobal(Offset.zero);
    Offset positionInputSuggestions = renderBoxInput.localToGlobal(Offset.zero);
    double horizontalPosition =
        positionInputSuggestions.dx - positionCardScaffold.dx;
    myOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: horizontalPosition,
          top: renderBoxInput.localToGlobal(Offset.zero).dy -
              (renderBoxInput.size.height / 2),
          bottom: value.height * 0.1,
          width: renderBoxInput.size.width,
          child: Card(
            elevation: 4,
            child: ListView.builder(
              itemCount: _suggestionsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_pin, size: 25.0),
                  title: formatString(
                      _suggestionsList[index], widget.addressController!.text),
                  onTap: () {
                    widget.addressController!.text = _suggestionsList[index];
                    coordinates =
                        _suggestions.features[index].geometry.coordinates;
                    removeOverlayEntry();
                    widget.onChangeLocation(
                        coordinates[1].toString(), coordinates[0].toString());
                  },
                );
              },
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(myOverlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _suggestionAddressBloc,
          ),
          BlocProvider(
            create: (context) => AvailablePositionBloc(GetIt.instance.get())
              ..add(const AvailablePositionStarted()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<SuggestionAddressBloc, SuggestionAddressState>(
                listener: (context, state) {
              if (state is SuggestionAddressSuccess) {
                setState(() {
                  _suggestions = state.addressList;
                  _suggestionsList = state.addressList.features
                      .map(
                        (e) => Properties.getFullLocation(e.properties),
                      )
                      .toList();
                });
                createOverlayEntry(context);
              }
            }),
            BlocListener<AvailablePositionBloc, AvailablePositionState>(
                listener: (context, state) {
              if (state is AvailablePositionResult) {
                setState(() {
                  warningInput = !state.available;
                });
              }
            })
          ],
          child: BlocBuilder<SuggestionAddressBloc, SuggestionAddressState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (value != MediaQuery.of(context).size) {
                    removeOverlayEntry();
                  }
                  return CustomTextField(
                    key: myKeyInputSuggestions,
                    label: 'Ubicación en el mapa',
                    withInputLabel: true,
                    suffix: state is SuggestionAddressLoading
                        ? const CupertinoActivityIndicator(
                            radius: 7,
                          )
                        : null,
                    prefix: const Icon(Icons.label_outline_rounded),
                    tooltip: warningInput
                        ? 'Pamphlets no se puede acceder a tu ubicación. Otorgue permisos para recibir sugerencias más precisas'
                        : null,
                    controller: widget.addressController,
                    onChange: (String? address) {
                      if (address != '' && address != null) {
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }
                        _debounce = Timer(const Duration(seconds: 1), () {
                          BlocProvider.of<SuggestionAddressBloc>(context)
                              .add(SearchAddress(address: address));
                        });
                      }
                      return null;
                    },
                  );
                },
              );
            },
          ),
        ));
  }

  Widget formatString(String text, String match) {
    List<String> components = text.split(', ');
    List<TextSpan> formattedComponents = [];

    String normalizedMatch = _normalizeString(match);

    for (String component in components) {
      String normalizedComponent = _normalizeString(component);

      if (normalizedComponent.contains(normalizedMatch)) {
        formattedComponents.add(
          TextSpan(
            text: component,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else {
        formattedComponents.add(
          TextSpan(text: component),
        );
      }

      if (components.indexOf(component) < components.length - 1) {
        formattedComponents.add(const TextSpan(text: ', '));
      }
    }

    return RichText(text: TextSpan(children: formattedComponents));
  }

  String _normalizeString(String input) {
    return input.replaceAll(RegExp(r'[\u0300-\u036f]'), '').toLowerCase();
  }
}
