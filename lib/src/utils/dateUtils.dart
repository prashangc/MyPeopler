import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
class MyDateUtils {
  static getDateOnly(DateTime? date) {
    if(date == null){
      return "";
    }
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
  static getNepaliDateOnly(NepaliDateTime? date) {
    if(date == null){
      return "";
    }
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
  static getTimeOnly(DateTime? date) {
    if(date == null){
      return "";
    }
    return DateFormat.jm().format(date.subtract(Duration(minutes: 0)));
    //"${date.hour.toString().padLeft(2,'0')}:${date.subtract(Duration(minutes: 5)).minute.toString().padLeft(2,'0')} ${getAmOrPM(date)}";
  }

  static getleaveDateOnly(NepaliDateTime date) {
    return "${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
  }

  static String getAmOrPM(DateTime date) {
    return date.hour < 12 ? "AM" : "PM";
  }

  // 2022-02-01 13:23 AM
  static getDateTime(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  // check for today date excluding the time
  static bool isToday(DateTime date) {
    var todayDate = DateTime.now();
    return (date.year == todayDate.year) &&
        (date.month == todayDate.month) &&
        (date.day == todayDate.day);
  }

  static String getMonthName(int monthNumber) {
    String monthName = "";
    switch (monthNumber) {
      case 1:
        monthName = "January";
        break;
      case 2:
        monthName = "February";
        break;
      case 3:
        monthName = "March";
        break;
      case 4:
        monthName = "April";
        break;
      case 5:
        monthName = "May";
        break;
      case 6:
        monthName = "June";
        break;
      case 7:
        monthName = "July";
        break;
      case 8:
        monthName = "August";
        break;
      case 9:
        monthName = "September";
        break;
      case 10:
        monthName = "October";
        break;
      case 11:
        monthName = "November";
        break;
      case 12:
        monthName = "December";
        break;
      default:
        monthName = "";
    }
    return monthName;
  }
}
