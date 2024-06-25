import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/metric_hour_bloc.dart';

class BarChartHour extends StatefulWidget {
  const BarChartHour({super.key, required this.eventId});
  final int eventId;

  @override
  State<BarChartHour> createState() => _BarChartHourState();
}

class _BarChartHourState extends State<BarChartHour> {
  late int showingTooltip;
  String? text;
  late List<BarChartGroupData> barGroups;

  @override
  void initState() {
    showingTooltip = -1;
    barGroups = List.generate(24, (hour) => generateGroupData(hour, 0));
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: Colors.blue,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MetricHourBloc, MetricHourState>(
      listener: (context, state) {
        if (state is MetricsHourSuccess) {
          if (state.loginsHourMetricsModel != null) {
            setState(() {
              barGroups =
                  List.generate(24, (hour) => generateGroupData(hour, 0));
              for (final logins in state.loginsHourMetricsModel!.logins) {
                final time = logins.loginHour;
                final count = int.parse(logins.loginsPerHour);
                if (time.hour >= 0 && time.hour < barGroups.length) {
                  barGroups[time.hour] = generateGroupData(time.hour, count);
                }
              }
              text = state.loginsHourMetricsModel!.eveName;
            });
          }
        }
      },
      child: Stack(children: [
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return BarChart(BarChartData(
                alignment: BarChartAlignment.spaceAround,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    axisNameWidget: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: BlocBuilder<MetricHourBloc, MetricHourState>(
                          builder: (context, state) {
                            if (state is MetricsHourLoading) {
                              return const Text(
                                'Cargando',
                                style: TextStyle(fontSize: 10),
                              );
                            }
                            return Text(
                              text ?? 'Evento',
                              style: const TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        )),
                    sideTitles: const SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    axisNameWidget: Padding(
                        padding: EdgeInsets.only(top: 6.0, left: 16),
                        child: Text(
                          'Cantidad de logins',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        )),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: barGroups,
                borderData: FlBorderData(
                    show: true,
                    border: const Border(
                        top: BorderSide.none,
                        left: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide.none)),
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return getBarTooltipItem(group, rod);
                    },
                    tooltipBgColor: Colors.transparent,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                    tooltipMargin: -15,
                    tooltipPadding: const EdgeInsets.all(5),
                  ),
                  touchCallback: (event, response) {
                    if (response != null &&
                        response.spot != null &&
                        event.isInterestedForInteractions) {
                      setState(() {
                        final x = response.spot!.touchedBarGroup.x;
                        final isShowing = showingTooltip == x;
                        if (isShowing) {
                          showingTooltip = -1;
                        } else {
                          showingTooltip = x;
                        }
                      });
                    }
                  },
                ),
              ));
            }),
          ),
        ),
        if (widget.eventId > 0)
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white70),
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'No contiene datos registrados',
                style: TextStyle(fontSize: 16, color: Colors.purple[600]),
              ),
            ),
          ),
      ]),
    );
  }

  BarTooltipItem getBarTooltipItem(
      BarChartGroupData group, BarChartRodData rod) {
    return BarTooltipItem(
      group.x == showingTooltip ? rod.toY.toString() : ' ',
      ChartStyles.tooltipTextStyle,
    );
  }
}

class ChartStyles {
  static const Color contentColorCyan = Colors.cyan;
  static const Color barColor = contentColorCyan;
  static const double barWidth = 15;
  static const BorderRadiusGeometry barBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
  );
  static TextStyle tooltipTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  static const Color gridLineColor = Colors.black;
}

Widget leftTitles(double value, TitleMeta meta) {
  if (value % 1 == 0 && value >= 1 && value <= 10) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: const TextStyle(fontSize: 10),
      ),
    );
  } else {
    return Container();
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 10,
    overflow: TextOverflow.ellipsis,
  );
  if (value >= 0 && value <= 23) {
    final hour = value.toInt();
    return SideTitleWidget(
      space: 10,
      axisSide: meta.axisSide,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SizedBox(
          width: 55.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    return Container();
  }
}