import 'package:intl/intl.dart';
import 'package:todo_flutter/core/extensions/num_extention.dart';

/**
 * Date formating from intl package
  ICU Name                   Skeleton
  --------                   --------
  DAY                          d
  ABBR_WEEKDAY                 E
  WEEKDAY                      EEEE
  ABBR_STANDALONE_MONTH        LLL
  STANDALONE_MONTH             LLLL
  NUM_MONTH                    M
  NUM_MONTH_DAY                Md
  NUM_MONTH_WEEKDAY_DAY        MEd
  ABBR_MONTH                   MMM
  ABBR_MONTH_DAY               MMMd
  ABBR_MONTH_WEEKDAY_DAY       MMMEd
  MONTH                        MMMM
  MONTH_DAY                    MMMMd
  MONTH_WEEKDAY_DAY            MMMMEEEEd
  ABBR_QUARTER                 QQQ
  QUARTER                      QQQQ
  YEAR                         y
  YEAR_NUM_MONTH               yM
  YEAR_NUM_MONTH_DAY           yMd
  YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
  YEAR_ABBR_MONTH              yMMM
  YEAR_ABBR_MONTH_DAY          yMMMd
  YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
  YEAR_MONTH                   yMMMM
  YEAR_MONTH_DAY               yMMMMd
  YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
  YEAR_ABBR_QUARTER            yQQQ
  YEAR_QUARTER                 yQQQQ
  HOUR24                       H
  HOUR24_MINUTE                Hm
  HOUR24_MINUTE_SECOND         Hms
  HOUR                         j
  HOUR_MINUTE                  jm
  HOUR_MINUTE_SECOND           jms
  HOUR_MINUTE_GENERIC_TZ       jmv
  HOUR_MINUTE_TZ               jmz
  HOUR_GENERIC_TZ              jv
  HOUR_TZ                      jz
  MINUTE                       m
  MINUTE_SECOND                ms
  SECOND                       s
 */

class DateTimeUtil {
  static DateTime getDayByDiff(int diff) {
    if (diff < 0) {
      return getCurrentDateTime(false).subtract(Duration(days: diff.abs()));
    } else {
      return getCurrentDateTime(false).add(Duration(days: diff));
    }
  }

  static String getFormattedStringFromDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String getFormattedStringFromTimeStamp(int timestamp, String format) {
    var time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return getFormattedStringFromDate(time, format);
  }

  static DateTime? getDateTimeFromString(String date, String format) {
    try {
      return DateFormat(format).parse(date);
    } on FormatException {
      return null;
    }
  }

  static getDateDifferenceInString({required num formattedDateString}) {
    if (formattedDateString == 0) {
      return '';
    }
    String finalString = '';
    DateTime currentDateTime = getCurrentDateTime(false);
    int currentDateTimeInMilliSeconds =
        getCurrentDateTime(false).millisecondsSinceEpoch;
    DateTime formattedDate;
    try {
      formattedDate = DateTime.fromMillisecondsSinceEpoch(
          formattedDateString.toInt() * 1000);
      formattedDate = formattedDate.toLocal();
    } on FormatException {
      return '';
    }
    int oneDayInMills = 24 * 60 * 60 * 1000;
    if ((currentDateTimeInMilliSeconds - formattedDate.millisecondsSinceEpoch) >
        oneDayInMills) {
      int lastActiveYear = formattedDate.year;
      int lastActiveDay = formattedDate.day;
      var formatter = new DateFormat('MMM');
      String lastActiveMonth = formatter.format(formattedDate);
      if (currentDateTime.year - formattedDate.year > 0) {
        finalString =
            "$lastActiveYear $lastActiveMonth ${lastActiveDay.addingZeroPrefix()}";
      } else {
        finalString = "$lastActiveMonth $lastActiveDay";
      }
    } else {
      if (currentDateTime.hour - formattedDate.hour > 0) {
        var diff = currentDateTime.hour - formattedDate.hour;
        if (diff == 1) {
          finalString = "$diff" + "hr ago";
        } else {
          finalString = "$diff" + "hrs ago";
        }
      } else if (currentDateTime.minute - formattedDate.minute > 0) {
        var diff = currentDateTime.minute - formattedDate.minute;
        if (diff == 1) {
          finalString = "$diff" + "min ago";
        } else {
          finalString = "$diff" + "mins ago";
        }
      } else {
        var diff = currentDateTime.second - formattedDate.second;
        if (diff == 1) {
          finalString = "$diff" + "sec ago";
        } else {
          finalString = "$diff" + "secs ago";
        }
      }
    }
    return finalString;
  }

  static String getSuffix(DateTime date) {
    String suffix = "";
    int day = date.day;
    if (day >= 4 && day <= 20) {
      suffix = "th";
    } else if (day % 10 == 1) {
      suffix = "st";
    } else if (day % 10 == 2) {
      suffix = "nd";
    } else if (day % 10 == 3) {
      suffix = "rd";
    } else {
      suffix = "th";
    }
    return suffix;
  }

  static bool isCurrentTimeStampOfNthDay(int n, int timestamp) {
    var now = getCurrentDateTime(false);
    var nthStart = DateTime(now.year, now.month, now.day + n);
    var nthEnd = DateTime(now.year, now.month, now.day + n, 24);

    return isFallInInterval(nthStart, nthEnd, timestamp);
  }

  static bool isCurrentTimeStampOfNthWeek(int n, int timestamp) {
    var now = getCurrentDateTime(false);
    var nthStart = getStartTimeForNthWeek(n);
    var nthEnd = DateTime(now.year, now.month, now.day - 1, 24);

    return isFallInInterval(nthStart, nthEnd, timestamp);
  }

  static DateTime getStartTimeForNthWeek(int n) {
    var now = getCurrentDateTime(false);
    return DateTime(now.year, now.month, now.day + (7 * n));
  }

  static bool isFallInInterval(DateTime start, DateTime end, int input) {
    return input * 1000 > start.millisecondsSinceEpoch &&
        end.millisecondsSinceEpoch >= input * 1000;
  }

  static bool isDateInrange(DateTime curr, DateTime start, DateTime end) {
    return start.compareTo(curr) <= 0 && curr.compareTo(end) <= 0;
  }

  static DateTime getStartOfDay([DateTime? dateTime]) {
    var dateToBeUsed = dateTime ?? getCurrentDateTime(false);
    var updatedDate =
        DateTime(dateToBeUsed.year, dateToBeUsed.month, dateToBeUsed.day);
    return updatedDate;
  }

  static DateTime getCurrentDateTime(bool shouldReturnSystemTime) {
    return DateTime.now();
  }
}
