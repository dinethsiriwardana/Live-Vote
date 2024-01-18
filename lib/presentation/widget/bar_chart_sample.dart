import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:live_vote/const.dart';
import 'package:live_vote/data/model/answer_model.dart';
import 'package:live_vote/data/model/single_event_model.dart';

class CustimBarChart extends StatelessWidget {
  final List<Answer> event;
  const CustimBarChart({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Answer maxVotesAnswer = event.reduce((currentMax, answer) =>
        answer.noOfVotes > currentMax.noOfVotes ? answer : currentMax);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: (maxVotesAnswer.noOfVotes + 5),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: CustomeColor().primaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
//
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: CustomeColor().primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '1';
        break;
      case 1:
        text = '2';
        break;
      case 2:
        text = '3';
        break;
      case 3:
        text = '4';
        break;
      case 4:
        text = '5';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          CustomeColor().primaryColor,
          CustomeColor().secondryColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: event[0].noOfVotes.toDouble(),
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: event[1].noOfVotes.toDouble(),
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: event[2].noOfVotes.toDouble(),
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: event[3].noOfVotes.toDouble(),
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

// class BarChartSample3 extends StatefulWidget {
//   const BarChartSample3({super.key});

//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }

// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return const AspectRatio(
//       aspectRatio: 2,
//       child: CustimBarChart(),
//     );
//   }
// }
