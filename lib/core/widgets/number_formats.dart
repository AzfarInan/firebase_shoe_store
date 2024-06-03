import 'package:intl/intl.dart';

String formatCurrency(double number) {
  final formatCurrency =
  NumberFormat.currency(symbol: "\$", decimalDigits: 2);
  return formatCurrency.format(number);
}

String formatNumber(double number) {
  if (number == number.toInt()) {
    return number.toInt().toString();
  } else {
    return NumberFormat('0.00').format(number);
  }
}