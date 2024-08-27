import 'package:intl/intl.dart';

extension DoubleExt on int {
  String toZar() {
    return NumberFormat.simpleCurrency(
      name: 'ZAR',
    ).format(this / 100);
  }
}

extension DateTimeExt on DateTime {
  String toFormattedString() {
    return DateFormat('d MMM yyyy').format(this);
  }
}