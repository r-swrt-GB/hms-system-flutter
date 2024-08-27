import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMEd().format(date);
}

String formatDateSlashes(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String formatDateTime(DateTime date) {
  return DateFormat.yMMMEd().add_jm().format(date);
}

String formatCurrency(int cents) {
  return NumberFormat.currency(symbol: 'R').format(cents / 100);
}

String capatilizeFirstLetter(String string) {
  return string[0].toUpperCase() + string.substring(1);
}
