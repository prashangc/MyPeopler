import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateHelper {
  static Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      confirmText: "OK",
      cancelText: "Cancel",
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 33, 28, 183),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 51, 27, 157),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) {
      return null;
    }
    return newDate;
  }

  static Future<NepaliDateTime?> pickNepaliDate(BuildContext context) async {
    final initialDate = NepaliDateTime.now();
    final newDate = await showMaterialDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: NepaliDateTime(NepaliDateTime.now().year - 100),
      lastDate: NepaliDateTime(NepaliDateTime.now().year + 100),
      confirmText: "OK",
      cancelText: "Cancel",
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 33, 28, 183),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 51, 27, 157),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) {
      return null;
    }
    return newDate;
  }

  static Future<DateTime?> pickFutureDate(BuildContext context, DateTime initialDate) async {

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(DateTime.now().year + 50),
      confirmText: "OK",
      cancelText: "Cancel",
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 27, 46, 194),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 28, 35, 166),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) {
      return null;
    }
    return newDate;
  }

  static Future<TimeOfDay?> pickTime(BuildContext context) async {
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      confirmText: "Ok",
      cancelText: "Cancel",
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          child: child!,
        );
      },
    );
    if (newTime == null) return null;
    return newTime;
  }

  // static Future<DateTime?> pickDateTime(BuildContext context) async {
  //   final date = await pickDate(context);
  //   if (date == null) return null;
  //   final time = await pickTime(context);
  //   if (time == null) return null;
  //   return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  // }

  // static Future<DateTime?> pickFutureDateTime(BuildContext context) async {
  //   final date = await pickFutureDate(context);
  //   if (date == null) return null;
  //   final time = await pickTime(context);
  //   if (time == null) return null;
  //   return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  // }
}