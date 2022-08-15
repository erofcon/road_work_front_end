import 'package:flutter/material.dart';

class TaskCardInfo {
  final int count;
  final String title;
  final Color primary;
  final Color textColor;
  final Widget iconWidget;

  TaskCardInfo({
    required this.count,
    required this.title,
    required this.primary,
    required this.textColor,
    required this.iconWidget,
  });
}

