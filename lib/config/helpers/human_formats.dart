import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HumanFormats {
  static void initializeDates() {
    initializeDateFormatting();
  }

  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMEd('es');

    return format.format(date);
  }
}
