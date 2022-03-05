import 'package:intl/intl.dart';

class Util {
  static String appId = "ed60fcfbd110ee65c7150605ea8aceea";

  static String getFormattedDate(int? seconds) {
    if (seconds == null) return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds*1000);
    return DateFormat("EEEE, MMM d, yyyy").format(dateTime);
  }
}
