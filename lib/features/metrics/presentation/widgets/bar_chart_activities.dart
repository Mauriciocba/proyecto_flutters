import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/select_activity_bloc.dart';

import '../../domain/entities/activity_metric.dart';
import 'app_colors.dart';

class BarCharActivity extends StatefulWidget {
  const BarCharActivity(
      {super.key,
      required this.dataMetric,
      required this.itemsPerPage,
      required this.currentPage});

  final int itemsPerPage;
  final int currentPage;
  final List<ActivityMetric> dataMetric;

  @override
  State<BarCharActivity> createState() => _BarCharActivityState();
}

class _BarCharActivityState extends State<BarCharActivity> {
  List<ActivityMetric> dataMetricAux = [];
  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    dataMetricAux = widget.dataMetric;
  }

  List<ActivityMetric> get currentPageData {
    final startIndex = widget.currentPage * widget.itemsPerPage;
    final endIndex = min(
        (widget.currentPage + 1) * widget.itemsPerPage, dataMetricAux.length);
    return dataMetricAux.sublist(startIndex, endIndex);
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      overflow: TextOverflow.ellipsis,
    );
    if (value.toInt() < dataMetricAux.length) {
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
                  dataMetricAux[value.toInt()].actName,
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

  Widget leftTitles(double value, TitleMeta meta) {
    if (value % 1 == 0) {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectActivityBloc, SelectActivityState>(
      listener: (context, state) {
        if (state is LoadNewEventSuccess) {
          List<ActivityMetric> newData = state.listActivity;
          setState(() {
            dataMetricAux = newData;
          });
        }
      },
      child: Stack(fit: StackFit.expand, children: [
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barsSpace = 4.0 * constraints.maxWidth / 400;
                    final barsWidth = 8.0 * constraints.maxWidth / 400;
                    return BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            fitInsideHorizontally: true,
                            fitInsideVertically: true,
                            tooltipHorizontalAlignment:
                                FLHorizontalAlignment.right,
                            tooltipMargin: -10,
                            tooltipPadding: const EdgeInsets.all(5),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return getBarTooltipItem(group, rod);
                            },
                          ),
                          touchCallback: (event, response) {
                            if (event.isInterestedForInteractions &&
                                response != null &&
                                response.spot != null) {
                              setState(() {
                                touchedGroupIndex =
                                    response.spot!.touchedBarGroupIndex;
                              });
                            } else {
                              setState(() {
                                touchedGroupIndex = -1;
                              });
                            }
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            axisNameWidget: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: BlocBuilder<SelectActivityBloc,
                                    SelectActivityState>(
                                  builder: (context, state) {
                                    if (state is LoadNewEventLoading) {
                                      return const Text(
                                        'Cargando',
                                        style: TextStyle(fontSize: 12),
                                      );
                                    }
                                    return const Text(
                                      'Actividades',
                                      style: TextStyle(fontSize: 12),
                                    );
                                  },
                                )),
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: bottomTitles,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            axisNameWidget: const Padding(
                                padding: EdgeInsets.only(top: 6.0, left: 16),
                                child: Text(
                                  'Cantidad de registros',
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
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => true,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.black.withOpacity(0.2),
                            strokeWidth: 1,
                          ),
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: const Border(
                                top: BorderSide.none,
                                left: BorderSide(color: Colors.black),
                                bottom: BorderSide(color: Colors.black),
                                right: BorderSide.none)),
                        groupsSpace: barsSpace,
                        barGroups: getData(barsWidth, barsSpace),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        if (dataMetricAux.isEmpty)
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

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    final List<BarChartGroupData> groupData = [];
    final List<ActivityMetric> currentPageData = this.currentPageData;

    for (int i = 0; i < currentPageData.length; i++) {
      final value = currentPageData[i].activityLogs;
      final valueDoble = double.parse(value);
      final List<BarChartRodData> barRods = [
        BarChartRodData(
          color: AppColors.contentColorCyan,
          toY: valueDoble,
          borderSide: const BorderSide(
            color: AppColors.contentColorCyan,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          width: 35,
        ),
      ];

      final group = BarChartGroupData(
        x: i,
        barsSpace: barsSpace,
        barRods: barRods,
        showingTooltipIndicators: [0],
      );

      groupData.add(group);
    }

    return groupData;
  }

  BarTooltipItem getBarTooltipItem(
      BarChartGroupData group, BarChartRodData rod) {
    return BarTooltipItem(
      group.x == touchedGroupIndex ? rod.toY.toString() : ' ',
      const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}
