import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metric_hour_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metrics_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/bar_chart_events.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/date_selectors.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/events_selector.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/legend_item.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/scatter_events.dart';
import 'package:pamphlets_management/utils/styles/web_theme.dart';

import 'app_colors.dart';
import 'bar_chart_hour.dart';

class LoginMetric extends StatefulWidget {
  const LoginMetric({super.key});

  @override
  State<LoginMetric> createState() => _LoginMetricState();
}

class _LoginMetricState extends State<LoginMetric> {
  int indexEventSelected = 0;
  int currentPageBarCharEvents = 0;
  int currentPageScatterEvents = 0;

  void nextPageBarCharEvents() {
    setState(() {
      currentPageBarCharEvents++;
    });
  }

  void previousPageBarCharEvents() {
    setState(() {
      currentPageBarCharEvents--;
    });
  }

  void nextPageScatterEvents() {
    setState(() {
      currentPageScatterEvents++;
    });
  }

  void previousPageScatterEvents() {
    setState(() {
      currentPageScatterEvents--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: BlocBuilder<MetricsBloc, MetricsState>(
        builder: (context, state) {
          bool hasNextPageBarCharEvents = false;
          bool hasNextPageScatterEvents = false;
          if (state is MetricsLoginsSuccess) {
            if (state.listLoginsEventsMetrics.isNotEmpty &&
                state.listLoginsHoursMetrics.isNotEmpty) {
              final totalEvents = state.listLoginsEventsMetrics.length;
              final totalEventsScatter = state.listLoginsHoursMetrics.length;
              final totalPagesEvents =
                  totalEvents ~/ 5 + (totalEvents % 5 != 0 ? 1 : 0);
              final totalPagesEventsScatter = totalEventsScatter ~/ 5 +
                  (totalEventsScatter % 5 != 0 ? 1 : 0);
              hasNextPageBarCharEvents =
                  currentPageBarCharEvents < totalPagesEvents - 1;
              hasNextPageScatterEvents =
                  currentPageScatterEvents < totalPagesEventsScatter - 1;
              BlocProvider.of<MetricHourBloc>(context).add(LoadMetricsHour(
                  eventId: state.listLoginsEventsMetrics[0].logins.eveId));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Esta pantalla muestra métricas de inicio de sesión, brindando visión sobre la actividad de los usuarios. Ofrece visualizaciones detalladas que muestran la cantidad de inicios de sesión por evento, la distribución a lo largo del día y la cantidad según la hora del día para eventos específicos.',
                  style: WebTheme.getTheme().textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                DateSelectorsWidget(onPressedFilter: (startDate, endDate) {
                  BlocProvider.of<MetricsBloc>(context)
                      .add(LoadMetricsLogins(start: startDate, end: endDate));
                }),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        'Inicios de sesión por evento',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text('Referencia: '),
                        SizedBox(width: 20.0),
                        LegendItem(color: Colors.grey, text: 'Inactivo'),
                        SizedBox(width: 20.0),
                        LegendItem(
                            color: AppColors.contentColorCyan, text: 'Activo')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: size.width * 1,
                  height: size.height * 0.4,
                  child: BarChartEvents(
                    dataMetric: state.listLoginsEventsMetrics,
                    itemsPerPage: 5,
                    currentPage: currentPageBarCharEvents,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageBarCharEvents > 0
                          ? previousPageBarCharEvents
                          : null,
                    ),
                    Text('Página ${currentPageBarCharEvents + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: hasNextPageBarCharEvents
                          ? nextPageBarCharEvents
                          : null,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Text(
                      'Inicios de sesión por hora del día',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )),
                    Row(children: [
                      LegendItem(
                          color: state.listColorsLimit[0].color,
                          text: 'Mínimo'),
                      const SizedBox(width: 20),
                      LegendItem(
                          color: state.listColorsLimit[1].color, text: 'Medio'),
                      const SizedBox(width: 20),
                      LegendItem(
                          color: state.listColorsLimit[2].color,
                          text: 'Máximo'),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.8,
                  child: ScatterEvents(
                    dataMetrics: state.listLoginsHoursMetrics,
                    currentPage: currentPageScatterEvents,
                    itemsPerPage: 5,
                    listScale: state.listColorsLimit,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageScatterEvents > 0
                          ? previousPageScatterEvents
                          : null,
                    ),
                    Text('Página ${currentPageScatterEvents + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: hasNextPageScatterEvents
                          ? nextPageScatterEvents
                          : null,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                const Text(
                  'Inicios de sesión por hora',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: size.width * 0.3,
                    child: EventsSelector(
                        listEvents: state.listLoginsEventsMetrics,
                        onEventSelected: (eventIdSelected) {
                          indexEventSelected = eventIdSelected;
                        })),
                const SizedBox(height: 30),
                SizedBox(
                  height: size.height * 0.4,
                  child: BarChartHour(eventId: indexEventSelected),
                ),
              ],
            );
          }
          if (state is MetricsLoading) {
            return SizedBox(
              height: size.height * 0.5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (state is MetricsFailure) {
            return SizedBox(
              height: size.height * 0.5,
              child: const Center(
                child: Text('FALLÓ EN LA CARGA DE LOS DATOS'),
              ),
            );
          }
          return SizedBox(
            height: size.height * 0.5,
            child: const Center(
              child: Text('NO FUE POSIBLE SOLICITAR LOS DATOS'),
            ),
          );
        },
      ),
    );
  }
}
