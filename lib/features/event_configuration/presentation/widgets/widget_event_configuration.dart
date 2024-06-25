// import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event_configuration/domain/entities/event_configuration_model.dart';
import 'package:pamphlets_management/features/event_configuration/presentation/bloc/event_configuration_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_elevate_button.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:pamphlets_management/utils/settings/list_utc.dart';

import '../../../event/presentation/widgets/widget_utc_selector.dart';

class WidgetEventConfiguration extends StatelessWidget {
  final EventConfigurationModel eventConfig;
  final int eventId;
  const WidgetEventConfiguration(
      {super.key, required this.eventId, required this.eventConfig});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _EventConfigurationCard(
                eventId: eventId,
                eventConfig: eventConfig,
              ),
            )
          ]),
    );
  }
}

class _EventConfigurationCard extends StatefulWidget {
  const _EventConfigurationCard({
    required this.eventId,
    required this.eventConfig,
  });

  final int eventId;
  final EventConfigurationModel eventConfig;

  @override
  State<_EventConfigurationCard> createState() =>
      _EventConfigurationCardState();
}

class _EventConfigurationCardState extends State<_EventConfigurationCard>
    with Toaster {
  Color? _colorPrimaryDark;
  Color? _secondary1Dark;
  Color? _secondary2Dark;
  Color? _secondary3Dark;
  Color? _accentDark;
  Color? _colorPrimaryLight;
  Color? _secondary1Light;
  Color? _secondary2Light;
  Color? _secondary3Light;
  Color? _accentLight;
  String? _selectedLanguage;
  String? _selectedFont;
  bool isSelectedPrimaryDark = false;
  bool isSelectedSecondary1Dark = false;
  bool isSelectedSecondary2Dark = false;
  bool isSelectedSecondary3Dark = false;
  bool isSelectedAccentDark = false;
  bool isSelectedPrimaryLight = false;
  bool isSelectedSecondary1Light = false;
  bool isSelectedSecondary2Light = false;
  bool isSelectedSecondary3Light = false;
  bool isSelectedAccentLight = false;
  late String _utcSelected;
  final List<String> _listUtc = getListUtc();

  @override
  void initState() {
    super.initState();
    _colorPrimaryDark = getColor(widget.eventConfig.estPrimaryColorDark);
    _secondary1Dark = getColor(widget.eventConfig.estSecondary1ColorDark);
    _secondary2Dark = getColor(widget.eventConfig.estSecondary2ColorDark);
    _secondary3Dark = getColor(widget.eventConfig.estSecondary3ColorDark);
    _accentDark = getColor(widget.eventConfig.estAccentColorDark);
    _colorPrimaryLight = getColor(widget.eventConfig.estPrimaryColorLight);
    _secondary1Light = getColor(widget.eventConfig.estSecondary1ColorLight);
    _secondary2Light = getColor(widget.eventConfig.estSecondary2ColorLight);
    _secondary3Light = getColor(widget.eventConfig.estSecondary3ColorLight);
    _accentLight = getColor(widget.eventConfig.estAccentColorLight);
    _selectedLanguage = widget.eventConfig.estLanguage.toUpperCase();
    _selectedFont = widget.eventConfig.estFont;
    _utcSelected = widget.eventConfig.estTimeZone;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 800,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Configuración',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                    ),
                    children: [
                      TextSpan(
                        text: ' Evento N° ${widget.eventConfig.estId}',
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
                  "Paleta de colores Tema Dark",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Color Primario Dark',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedPrimaryDark = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedPrimaryDark ? 60 : 50,
                            height: isSelectedPrimaryDark ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _colorPrimaryDark,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _colorPrimaryDark ?? Colors.black);
                            // setState(() {
                            //   _colorPrimaryDark = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 1 Dark',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary1Dark = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary1Dark ? 60 : 50,
                            height: isSelectedSecondary1Dark ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary1Dark,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary1Dark ?? Colors.black);

                            // setState(() {
                            //   _secondary1Dark = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 2 Dark',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary2Dark = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary2Dark ? 60 : 50,
                            height: isSelectedSecondary2Dark ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary2Dark,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary2Dark ?? Colors.black);
                            // setState(() {
                            //   _secondary2Dark = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 3 Dark',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary3Dark = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary3Dark ? 60 : 50,
                            height: isSelectedSecondary3Dark ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary3Dark,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary3Dark ?? Colors.black);

                            // setState(() {
                            //   _secondary3Dark = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Accent Dark',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedAccentDark = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedAccentDark ? 60 : 50,
                            height: isSelectedAccentDark ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _accentDark,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _accentDark ?? Colors.black);

                            // setState(() {
                            //   _accentDark = color;
                            // });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Paleta de colores Tema Light",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Color Primario Light',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedPrimaryLight = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedPrimaryLight ? 60 : 50,
                            height: isSelectedPrimaryLight ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _colorPrimaryLight,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _colorPrimaryLight ?? Colors.black);

                            // setState(() {
                            //   _colorPrimaryLight = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 1 Light',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary1Light = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary1Light ? 60 : 50,
                            height: isSelectedSecondary1Light ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary1Light,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary1Light ?? Colors.black);

                            // setState(() {
                            //   _secondary1Light = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 2 Light',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary2Light = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary2Light ? 60 : 50,
                            height: isSelectedSecondary2Light ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary2Light,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary2Light ?? Colors.black);

                            // setState(() {
                            //   _secondary2Light = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Secundario 3 Light',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedSecondary3Light = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedSecondary3Light ? 60 : 50,
                            height: isSelectedSecondary3Light ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _secondary3Light,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _secondary3Light ?? Colors.black);

                            // setState(() {
                            //   _secondary3Light = color;
                            // });
                          }),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Tooltip(
                      message: 'Accent Light',
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          hoverColor: Colors.white,
                          onHover: (value) {
                            setState(() {
                              isSelectedAccentLight = value;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelectedAccentLight ? 60 : 50,
                            height: isSelectedAccentLight ? 60 : 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: _accentLight,
                            ),
                          ),
                          onTap: () async {
                            // final color = await showColorPickerDialog(
                            //     context, _accentLight ?? Colors.black);
                            // setState(() {
                            //   _accentLight = color;
                            // });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Lenguaje",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      elevation: 0,
                      icon: const Icon(Icons.language),
                      value: _selectedLanguage,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                      },
                      items: <String>['EN', 'ES']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Fuente",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      elevation: 0,
                      icon: const Icon(Icons.font_download),
                      value: _selectedFont,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFont = newValue;
                        });
                      },
                      items: <String>['Roboto', 'Inter', 'Montserrat']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Seleccionar zona horaria',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: "UTC: Tiempo universal coordinado",
                            child: Icon(
                              Icons.help_outline,
                              size: 16,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      WidgetUtcSelector(
                        listEvents: _listUtc,
                        onEventSelected: (utcSelected) {
                          _utcSelected = utcSelected;
                        },
                        initialValue: _utcSelected,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: CustomTextButton(
                    label: const Text("Guardar"),
                    expanded: false,
                    onPressed: () async {
                      String convertirColorAHexadecimal(Color color) {
                        return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
                      }

                      String primaryDarkController =
                          convertirColorAHexadecimal(_colorPrimaryDark!);
                      String secondary1DarkController =
                          convertirColorAHexadecimal(_secondary1Dark!);
                      String secondary2DarkController =
                          convertirColorAHexadecimal(_secondary2Dark!);
                      String secondary3DarkController =
                          convertirColorAHexadecimal(_secondary3Dark!);
                      String accentDarkController =
                          convertirColorAHexadecimal(_accentDark!);
                      String primaryLightController =
                          convertirColorAHexadecimal(_colorPrimaryLight!);
                      String secondary1LightController =
                          convertirColorAHexadecimal(_secondary1Light!);
                      String secondary2LightController =
                          convertirColorAHexadecimal(_secondary2Light!);
                      String secondary3LightController =
                          convertirColorAHexadecimal(_secondary3Light!);
                      String accentLightController =
                          convertirColorAHexadecimal(_accentLight!);

                      context
                          .read<EventConfigurationBloc>()
                          .add(EditEventConfigurationStart(
                            modelConfiguration: EventConfigurationModel(
                                estId: widget.eventConfig.estId,
                                estPrimaryColorDark: primaryDarkController,
                                estSecondary1ColorDark:
                                    secondary1DarkController,
                                estSecondary2ColorDark:
                                    secondary2DarkController,
                                estSecondary3ColorDark:
                                    secondary3DarkController,
                                estAccentColorDark: accentDarkController,
                                estPrimaryColorLight: primaryLightController,
                                estSecondary1ColorLight:
                                    secondary1LightController,
                                estSecondary2ColorLight:
                                    secondary2LightController,
                                estSecondary3ColorLight:
                                    secondary3LightController,
                                estAccentColorLight: accentLightController,
                                estLanguage: _selectedLanguage.toString(),
                                estFont: _selectedFont.toString(),
                                estTimeZone: _utcSelected,
                                eveId: widget.eventId),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getColor(String dato) {
    try {
      String colorHex = dato;

      if (colorHex.startsWith('#')) {
        colorHex = colorHex.substring(1);
      }
      String flutterColorHex = '0xFF$colorHex';
      final color = Color(int.parse(flutterColorHex));
      return color;
    } catch (e) {
      return Colors.black;
    }
  }
}
