import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/payment_date_model.dart';

import 'app_colors.dart';

class BarCharPayment extends StatefulWidget {
  const BarCharPayment(
      {super.key,
      required this.dataMetric,
      required this.itemsPerPage,
      required this.currentPage});

  final int itemsPerPage;
  final int currentPage;
  final List<PaymentDateModel> dataMetric;

  @override
  State<BarCharPayment> createState() => _BarCharPaymentState();
}

class _BarCharPaymentState extends State<BarCharPayment> {
  int touchedGroupIndex = -1;

  List<PaymentDateModel> get currentPageData {
    final startIndex = widget.currentPage * widget.itemsPerPage;
    final endIndex = min((widget.currentPage + 1) * widget.itemsPerPage,
        widget.dataMetric.length);
    return widget.dataMetric.sublist(startIndex, endIndex);
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final list = currentPageData;
    if (value.toInt() < list.length) {
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
                  currentPageData[value.toInt()].eveName,
                  style: const TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
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

  Color _getColorText(double value) {
    currentPageData[value.toInt()].eveEnd.isAfter(DateTime.now())
        ? Colors.grey
        : AppColors.contentColorCyan;
    return AppColors.contentColorCyan;
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
    return Stack(fit: StackFit.expand, children: [
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
                          tooltipBgColor: Colors.blue,
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
                          axisNameWidget: const Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Text(
                                'Eventos',
                                style: TextStyle(fontSize: 10),
                                overflow: TextOverflow.ellipsis,
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
                                'Cantidad de pagos',
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
      if (widget.dataMetric.isEmpty)
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white70),
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'No contiene datos registrados',
              style: TextStyle(fontSize: 16, color: Colors.purple[600]),
            ),
          ),
        ),
    ]);
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    final List<BarChartGroupData> groupData = [];
    final List<PaymentDateModel> currentPageData = this.currentPageData;

    for (int i = 0; i < currentPageData.length; i++) {
      final value = currentPageData[i].payments.isNotEmpty
          ? currentPageData[i].payments[0].amountOfPayments
          : '0';
      final valueDoble = double.parse(value);
      final List<BarChartRodData> barRods = [
        BarChartRodData(
          color: _getColorText(valueDoble),
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
      _getToolTip(group, rod),
      Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.black) ??
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
    );
  }

  String _getToolTip(BarChartGroupData group, BarChartRodData rod) {
    if (group.x == touchedGroupIndex) {
      final paymentData = currentPageData[group.x];
      final paymentTypeEvent = paymentData.payments.isNotEmpty
          ? paymentData.payments[0].payType
          : '';
      final paymentTypeNetworking = paymentData.payments.isNotEmpty &&
              paymentData.payments[1].payType.isNotEmpty
          ? paymentData.payments[1].payType
          : '';

      return '${rod.toY.toString()}\n Tipo de pagos: $paymentTypeEvent y $paymentTypeNetworking';
    } else {
      return '';
    }
  }
}
