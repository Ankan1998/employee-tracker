import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperUtil {
  static DateTime getNextWeekday(DateTime inputDate, int weekday) {
    int daysUntilNextMonday = weekday - inputDate.weekday;
    if (daysUntilNextMonday <= 0) {
      daysUntilNextMonday += 7;
    }
    DateTime nextMonday = inputDate.add(Duration(days: daysUntilNextMonday));

    return nextMonday;
  }

  static String formatDate_dMMMy(DateTime? dateTime) {
    if (dateTime != null) {
      final formatter = DateFormat('d MMM y');
      return formatter.format(dateTime);
    } else {
      return '';
    }
  }

  static String formatDateToCustomString(DateTime dateTime) {
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static DateTime parseCustomStringToDate(String dateString) {
    List<String> parts = dateString.split('-');
    if (parts.length == 3) {
      int year = int.tryParse(parts[0]) ?? 0;
      int month = int.tryParse(parts[1]) ?? 1;
      int day = int.tryParse(parts[2]) ?? 1;
      return DateTime(year, month, day);
    }
    return DateTime.now();
  }

  static bool isNotToday(DateTime selectedDate) {
    final now = DateTime.now();
    bool isNotToday = selectedDate.year != now.year || selectedDate.month != now.month || selectedDate.day != now.day;
    return isNotToday;
  }

  static int isPrevEmployee(DateTime endDate) {
    if (endDate == DateTime(1980) || endDate.isAfter(DateTime.now())) {
      return 0;
    } else {
      return 1;
    }
  }

  static MaterialColor createMaterialColor(Color color) {
    List<Color> shades = [
      color,
      color.withOpacity(0.8),
      color.withOpacity(0.6),
      color.withOpacity(0.4),
      color.withOpacity(0.2),
      color.withOpacity(0.1),
    ];

    Map<int, Color> swatch = {
      50: shades[5],
      100: shades[4],
      200: shades[3],
      300: shades[2],
      400: shades[1],
      500: shades[0],
      600: shades[1],
      700: shades[2],
      800: shades[3],
      900: shades[4],
    };

    return MaterialColor(color.value, swatch);
  }
}
