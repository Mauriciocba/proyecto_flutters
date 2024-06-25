import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';
import 'package:pamphlets_management/utils/common/widget_image_loader.dart';

import '../../domain/entities/event.dart';

class TableEvent extends StatelessWidget {
  final List<Event> eventList;

  const TableEvent({super.key, required this.eventList});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Lista de Eventos Disponibles',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/createEventPage');
                  },
                  child: const Text('Crear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Expanded(child: Text('Logo del evento'))),
                  DataColumn(label: Expanded(child: Text('Nombre del Evento'))),
                  DataColumn(
                      label: Expanded(child: Text('Descripción del evento'))),
                  DataColumn(label: Expanded(child: Text('Fecha de Inicio'))),
                  DataColumn(label: Expanded(child: Text('Fecha de Fin'))),
                ],
                rows: eventList.map((evento) {
                  return DataRow(cells: [
                    DataCell(
                      Container(
                        padding: const EdgeInsets.all(3),
                        width: 80,
                        height: 80,
                        child: evento.eveIcon != null
                            ? WidgetImageLoader(
                                image: evento.eveIcon ?? '',
                                iconErrorLoad: const Icon(Icons.image))
                            : const Icon(
                                Icons.image,
                              ),
                      ),
                    ),
                    DataCell(
                      Text(
                        evento.eveName,
                        style: const TextStyle(color: Colors.indigo),
                      ),
                      onTap: () {
                        context.go('/infoEventPage/${evento.eveId}');
                      },
                    ),
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: 400,
                          child: Text(
                            evento.eveDescription,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(formatterDate(evento.eveStart))),
                    DataCell(Text(
                      formatterDate(evento.eveEnd),
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
