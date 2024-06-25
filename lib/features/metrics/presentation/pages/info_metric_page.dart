import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/activities_metrics_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metrics_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/payment_bloc.dart';

import '../../../../utils/common/card_scaffold.dart';
import '../mock.dart';
import '../widgets/activity_metrics.dart';
import '../widgets/login_metric.dart';
import '../widgets/payments_metric.dart';

class InfoMetricPage extends StatefulWidget {
  const InfoMetricPage({super.key});

  @override
  State<InfoMetricPage> createState() => _InfoMetricPageState();
}

class _InfoMetricPageState extends State<InfoMetricPage>
    with TickerProviderStateMixin {
  late List<Widget Function()> _pagesMetricsFactory;
  var _selectedEventIndex = 0;
  @override
  void initState() {
    super.initState();
    _pagesMetricsFactory = <Widget Function()>[
      () => const LoginMetric(),
      () => const PaymentsMetric(),
      () => const ActivityMetricWidget(),
    ];
  }

  bool _isSelected(int index) {
    return _selectedEventIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    return CardScaffold(
        appBar: const CustomAppBar(
          title: "Métricas",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.0),
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: metricsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              _sectionSelection(context, index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: _isSelected(index)
                                    ? colorTheme.primary.withOpacity(0.1)
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    metricsList[index].iconData.icon,
                                    size: 20,
                                    color: _isSelected(index)
                                        ? colorTheme.primary
                                        : null,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    metricsList[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: _isSelected(index)
                                          ? colorTheme.primary
                                          : null,
                                      fontWeight: _isSelected(index)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              const Divider(height: 0.5),
              _pagesMetricsFactory[_selectedEventIndex].call()
            ],
          ),
        ));
  }

  void _sectionSelection(BuildContext context, int index) {
    setState(() {
      switch (index) {
        case 0:
          BlocProvider.of<MetricsBloc>(context)
              .add(const LoadMetricsLogins(start: null, end: null));
        case 1:
          BlocProvider.of<PaymentBloc>(context)
              .add(const LoadPayment(startDate: null, endDate: null));
          break;
        case 2:
          BlocProvider.of<ActivitiesMetricsBloc>(context)
              .add(const LoadActivitiesMetricsEvents(eventId: null));
        default:
          break;
      }
      _selectedEventIndex = index;
    });
  }
}
