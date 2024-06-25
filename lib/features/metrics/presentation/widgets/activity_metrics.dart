import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/bar_chart_activities.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/date_selectors.dart';
import 'package:pamphlets_management/features/metrics/presentation/widgets/events_selector_events.dart';
import '../../../../utils/styles/web_theme.dart';
import '../bloc/activities_metrics_bloc.dart';

class ActivityMetricWidget extends StatefulWidget {
  const ActivityMetricWidget({super.key});

  @override
  State<ActivityMetricWidget> createState() => _ActivityMetricWidgetState();
}

class _ActivityMetricWidgetState extends State<ActivityMetricWidget> {
  int indexEventSelected = 0;
  int currentPageBarCharActivity = 0;
  bool hasNextPageBarCharActivity = false;

  void nextPageBarCharActivity() {
    setState(() {
      currentPageBarCharActivity++;
    });
  }

  void previousPageBarCharActivity() {
    setState(() {
      currentPageBarCharActivity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<ActivitiesMetricsBloc, ActivitiesMetricsState>(
            builder: (context, state) {
          if (state is ActivitiesEventSuccess) {
            final totalActivity = state.lisActivityMetric.length;
            final totalPagesActivity =
                totalActivity ~/ 5 + (totalActivity % 5 != 0 ? 1 : 0);
            hasNextPageBarCharActivity =
                currentPageBarCharActivity < totalPagesActivity - 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Esta pantalla proporciona una visión detallada de las métricas de actividades, ofreciendo información sobre los registros de los usuarios, es decir cuando un usuario agenda una actividad. Permitiendo analizar la actividad de los usuarios y comprender mejor su participación en diferentes actividades del evento.',
                  style: WebTheme.getTheme().textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                DateSelectorsWidget(
                  onPressedFilter: (startDate, endDate) {
                    BlocProvider.of<ActivitiesMetricsBloc>(context).add(
                        LoadActivitiesMetricsEvents(
                            eventId: indexEventSelected != 0
                                ? indexEventSelected
                                : null,
                            startDate: startDate,
                            endDate: endDate));
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Registros',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                EventsSelectorActivitiesMetrics(
                  listEvents: state.listEvents,
                  onEventSelected: (eventId) {
                    indexEventSelected = eventId;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: size.height * 0.4,
                  child: BarCharActivity(
                      itemsPerPage: 5,
                      currentPage: currentPageBarCharActivity,
                      dataMetric: state.lisActivityMetric),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPageBarCharActivity > 0
                          ? previousPageBarCharActivity
                          : null,
                    ),
                    Text('Página ${currentPageBarCharActivity + 1}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: hasNextPageBarCharActivity
                          ? nextPageBarCharActivity
                          : null,
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is ActivitiesMetricsLoading) {
            return SizedBox(
              height: size.height * 0.5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (state is ActivitiesEventFailure) {
            return SizedBox(
              height: size.height * 0.5,
              child: Center(
                child: Text(state.message),
              ),
            );
          }
          return SizedBox(
            height: size.height * 0.5,
            child: const Center(
              child: Text('NO FUE POSIBLE SOLICITAR LOS DATOS'),
            ),
          );
        }));
  }
}
