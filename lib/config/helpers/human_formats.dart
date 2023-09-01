import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HumanFormats {
  static void initializeDates() {
    initializeDateFormatting();
  }

  static String shortDate(DateTime date, String language) {
    final format = DateFormat.yMMMEd(language);

    return format.format(date);
  }
}
