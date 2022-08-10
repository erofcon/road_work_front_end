import 'package:flutter/material.dart';

class TaskCardInfo {
  final int count;
  final String title;
  final Color primary;
  final Color textColor;

  TaskCardInfo({
    required this.count,
    required this.title,
    required this.primary,
    required this.textColor,
  });
}


List<TaskCardInfo> taskData = [
  TaskCardInfo(title: 'Текущие задачи', count: 120, primary: Colors.orange, textColor: Colors.white),
  TaskCardInfo(title: 'Выполненые задачи', count: 12, primary: Colors.green, textColor: Colors.white),
  TaskCardInfo(title: 'Просроченные задачи', count: 12, primary: Colors.red, textColor: Colors.white),
];