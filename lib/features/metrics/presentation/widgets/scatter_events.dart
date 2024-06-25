import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/colors_limit.dart';
import '../../domain/entities/logins_hour_metrics_model.dart';

class ScatterEvents extends StatelessWidget {
  const ScatterEvents(
      {super.key,
      required this.dataMetrics,
      required this.currentPage,
      required this.itemsPerPage,
      required this.listScale});
  final List<LoginsHourMetricsModel> dataMetrics;
  final int currentPage;
  final int itemsPerPage;
  final List<ColorsLimit> listScale;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: [
          _buildScatterChart(context),
          if (dataMetrics.isEmpty)
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
      ),
    );
  }

  Color getColorForYValue(String y) {
    int yInt = int.parse(y);
    Color color = Colors.transparent;
    for (ColorsLimit rangeColor in listScale) {
      if (yInt > 0 && yInt <= rangeColor.limit) {
        color = rangeColor.color;
        break;
      }
    }
    return color;
  }

  Widget _buildScatterChart(BuildContext context) {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (currentPage + 1) * itemsPerPage;
    List<LoginsHourMetricsModel> visibleMetrics = dataMetrics.sublist(
      startIndex.clamp(0, dataMetrics.length),
      endIndex.clamp(0, dataMetrics.length),
    );

    List<ScatterSpot> scatterSpots = visibleMetrics.expand((metric) {
      int index = dataMetrics.indexOf(metric);
      double x = index.toDouble();

      return metric.logins.map((login) {
        double y = login.loginHour.hour.toDouble();
        return ScatterSpot(x, y,
            dotPainter: FlDotCirclePainter(
                radius: 6,
                color: getColorForYValue(metric.logins[0].loginsPerHour)),
            show: true);
      });
    }).toList();

    ScatterChartData scatterData = ScatterChartData(
        minX: startIndex.toDouble() - 1,
        maxX: (startIndex + itemsPerPage).toDouble(),
        minY: -1,
        maxY: 24,
        scatterTouchData: ScatterTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: ScatterTouchTooltipData(
            tooltipBgColor: Colors.blueAccent,
            tooltipPadding: const EdgeInsets.all(6),
            getTooltipItems: (ScatterSpot touchedSpot) {
              final metric = dataMetrics[touchedSpot.x.toInt()];
              return ScatterTooltipItem(
                  '${metric.eveName}\nInicios de sesion: ${metric.logins[0].loginsPerHour}',
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white));
            },
          ),
        ),
        borderData: FlBorderData(
            show: true,
            border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(color: Colors.black),
                bottom: BorderSide(color: Colors.black))),
        scatterSpots: scatterSpots,
        gridData: FlGridData(
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return const FlLine(color: Colors.grey, strokeWidth: 0.5);
            }),
        titlesData: FlTitlesData(
            show: true,
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                axisNameWidget: const Text(
                  'Eventos',
                  style: TextStyle(fontSize: 12),
                ),
                sideTitles: SideTitles(
                  interval: 1,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value >= 0 &&
                        value < dataMetrics.length &&
                        dataMetrics.isNotEmpty) {
                      final int index = value.toInt();
                      return Text(
                        dataMetrics[index].eveName,
                        style: const TextStyle(fontSize: 10),
                      );
                    }
                    return const Text('');
                  },
                )),
            leftTitles: AxisTitles(
                axisNameSize: 10.0,
                sideTitles: SideTitles(
                    reservedSize: 50,
                    interval: 1,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value == -1) {
                        return const Text('');
                      }
                      if (value == 24) {
                        return const Text('');
                      }
                      return Text('${value.toString().padLeft(2, '0')}:00');
                    }))));

    return ScatterChart(scatterData);
  }
}
