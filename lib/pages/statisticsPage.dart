import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../widgets/moneySummary.dart';
import '../widgets/navbar.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  List<FlSpot> generateSpots() {
    List<FlSpot> flSpots = [];

    final DateTime currentDate = DateTime.now();
    final DateTime thirtyDaysAgo = currentDate.subtract(
        const Duration(days: 30));

    List<Transaction> transactions = db.transactions.value;

    double sum = 0.0;
    for (int index = 0; index < transactions.length; index++) {
      var transaction = transactions[index];
      if (transaction.createdAt.isBefore(currentDate) &&
          transaction.createdAt.isAfter(thirtyDaysAgo)) {
        sum += transaction.amount;
        flSpots.add(FlSpot(index.toDouble(), sum));
      }
    }

    return flSpots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1.', style: style);
        break;
      case 1:
        text = const Text('9.', style: style);
        break;
      case 2:
        text = const Text('18.', style: style);
        break;
      default:
        text = const Text('27.', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white);
    String text;
    switch (value.toInt()) {
      case -10:
        text = '-10€';
        break;
      case 10:
        text = '10€';
        break;
      case 30:
        text = '30€';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF2D2D2D),
        body: Stack(
          children: [
            Positioned(
              left: -80,
              top: -132,
              child: Container(
                width: 342,
                height: 342,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.55, -0.84),
                    end: Alignment(-0.55, 0.84),
                    colors: [Color(0xFF00B512), Color(0x0000B512)],
                  ),
                  shape: OvalBorder(),
                ),
              ),
            ),
            SingleChildScrollView(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Statistics",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Francois One',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const MoneySummary(),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      height: 200,
                      padding: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF737373),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: LineChart(LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 10,
                          verticalInterval: 1,
                          getDrawingHorizontalLine: (value) {
                            return const FlLine(
                                strokeWidth: 1, color: Colors.white);
                          },
                          getDrawingVerticalLine: (value) {
                            return const FlLine(
                                strokeWidth: 1, color: Colors.white);
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: bottomTitleWidgets,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.white),
                        ),
                        maxY: 40,
                        minY: -20,
                        lineBarsData: [
                          LineChartBarData(
                            color: Color(0xFF00B512),
                            spots: generateSpots(),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Color(0x3F00B512)
                            ),
                          ),
                        ],
                      )))
                ],
              ),
            )),
            const Navbar()
          ],
        ));
  }
}
