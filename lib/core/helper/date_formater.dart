import 'package:intl/intl.dart';

class DateFormater {
  static String formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
