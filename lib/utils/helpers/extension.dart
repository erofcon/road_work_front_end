import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatdMMMMY() {
    return DateFormat('d MMMM y').format(this);
  }

  String formatMMMMY() {
    return DateFormat('MMMM').format(this);
  }
}
