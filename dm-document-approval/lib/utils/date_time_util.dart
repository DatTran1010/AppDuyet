import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formattedDateTime(DateTime dateTime) {
    var duration = dateTime.timeZoneOffset;

    String dateTimeString =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime);
    String timeZoneOffset =
        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}";
    String timeZoneSymbol = duration.isNegative ? "" : "+";

    return "$dateTimeString$timeZoneSymbol$timeZoneOffset";
  }

  static DateTime dateTimeFromString(String dateTimeFormated) {
    if (!dateTimeFormated.contains("T")) {
      List<String> dateTimeSplit = dateTimeFormated.split(" ");
      List<String> dateSplit = dateTimeSplit[0].split("/");
      String formated =
          "${dateSplit[2]}-${dateSplit[0]}-${dateSplit[1]}T${dateTimeSplit[1]}.000";
      return DateTime.parse(formated);
    }
    return DateTime.parse(dateTimeFormated);
  }
}
