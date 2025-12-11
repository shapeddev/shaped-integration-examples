import 'package:flutter/material.dart';
import 'package:flutter_example/provider/level_provider.dart';
import 'package:flutter_example/utils/image_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class CaptureSdkLevel extends ConsumerStatefulWidget {
  const CaptureSdkLevel({super.key});

  @override
  CaptureSdkLevelState createState() => CaptureSdkLevelState();
}

class CaptureSdkLevelState extends ConsumerState<CaptureSdkLevel> {
  @override
  Widget build(BuildContext context) {
    final levelDevice = ref.watch(levelProvider.notifier).get();
    final imageSize = levelDevice.imageSize;
    final offsetX = levelDevice.offsetX;
    final offsetY = levelDevice.offsetY;
    final isLevelRight = levelDevice.isLevelRight;

    return !isLevelRight
        ? Center(
            child: Container(
              width: ImageSize.getWidthFromImage(imageSize.width, context),
              height: ImageSize.getHeightFromImage(
                imageSize.width,
                imageSize.height,
                context,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        minX: -100,
                        maxX: 100,
                        maxY: 100,
                        minY: -350,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(
                                -100,
                                -offsetX.round().toDouble() +
                                    offsetY.round().toDouble(),
                              ),
                              FlSpot(
                                100,
                                offsetX.round().toDouble() +
                                    offsetY.round().toDouble(),
                              ),
                            ],
                            isCurved: true,
                            gradient: LinearGradient(
                              colors: [
                                isLevelRight
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.error,
                                Colors.transparent,
                              ],
                            ),
                            barWidth: 0,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  isLevelRight
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.error,
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          LineChartBarData(
                            spots: [
                              const FlSpot(80, 97),
                              const FlSpot(99.5, 97),
                            ],
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                          ),
                          LineChartBarData(
                            spots: [
                              const FlSpot(-80, 97),
                              const FlSpot(-99.5, 97),
                            ],
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
