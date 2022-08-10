import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> taskChartData = [
  PieChartSectionData(
    color: Colors.orange,
    value: 25,
    showTitle: true,
    radius: 75,
    titleStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      letterSpacing: 1,
    ),
  ),
  PieChartSectionData(
    color: Colors.green,
    value: 20,
    showTitle: true,
    radius: 82,
    titleStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      letterSpacing: 1,
    ),
  ),
  PieChartSectionData(
    color: Colors.red,
    value: 10,
    showTitle: true,
    radius: 89,
    titleStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      letterSpacing: 1,
    ),
  ),
];
