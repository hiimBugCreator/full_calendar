import 'package:full_calender/full_calender.dart';
import 'package:full_calender/models/lunar_date_time.dart';

class FullCalenderExtension {
  static final _temp = FullCalender.now(7);

  /// Convert a Julian day number to day/month/year. Parameter jd is an integer.
  static DateTime convertJulianDayToSolarDate(int jd) {
    int a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      a = jd + 32044;
      b = ((4 * a + 3) / 146097).floor();
      c = a - ((b * 146097) / 4).floor();
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = ((4 * c + 3) / 1461).floor();
    e = c - ((1461 * d) / 4).floor();
    m = ((5 * e + 2) / 153).floor();
    day = e - ((153 * m + 2) / 5).floor() + 1;
    month = m + 3 - 12 * (m / 10).floor();
    year = b * 100 + d - 4800 + (m / 10).floor();
    return DateTime(year, month, day);
  }

  /// Convert lunar date to the corresponding solar date.
  static DateTime? convertLunarDateToSolarDate(
    LunarDateTime lunarDateTime, [
    int timeZone = 7,
  ]) {
    const double juliusDaysIn1900 = 2415021.076998695;
    const double newMoonCycle = 29.530588853;
    const int daysInYear = 365;
    int k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarDateTime.month < 11) {
      a11 = _temp.getLunarMonth11(lunarDateTime.year - 1, timeZone);
      b11 = _temp.getLunarMonth11(lunarDateTime.year, timeZone);
    } else {
      a11 = _temp.getLunarMonth11(lunarDateTime.year, timeZone);
      b11 = _temp.getLunarMonth11(lunarDateTime.year + 1, timeZone);
    }
    k = (0.5 + (a11 - juliusDaysIn1900) / newMoonCycle).floor();
    off = lunarDateTime.month - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > daysInYear) {
      leapOff = _temp.getLeapMonthOffset(a11, timeZone);
      leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarDateTime.isLeap && (lunarDateTime.month != leapMonth)) {
        return null;
      } else if (lunarDateTime.isLeap || (off >= leapOff)) {
        off += 1;
      }
    }
    monthStart = _temp.getNewMoonDay(k + off, timeZone);
    return convertJulianDayToSolarDate(monthStart + lunarDateTime.day - 1);
  }

  /// Convert lunar date to the julian day.
  static int convertLunarDateToJulianDay(
    LunarDateTime lunarDateTime, [
    int timeZone = 7,
  ]) {
    return FullCalender(
            date: convertLunarDateToSolarDate(lunarDateTime, timeZone) ??
                DateTime.now(),
            timeZone: timeZone)
        .julianDay;
  }

  /// Calculate range from two date
  static int? _rangeDate(dynamic fromDate, dynamic toDate) {
    if ((fromDate is DateTime || fromDate is LunarDateTime) &&
        (toDate is DateTime || toDate is LunarDateTime)) {
      var numOfFDay = (fromDate is LunarDateTime)
          ? convertLunarDateToJulianDay(fromDate)
          : FullCalender(date: fromDate, timeZone: 7).julianDay;
      var numOfTDay = (toDate is LunarDateTime)
          ? convertLunarDateToJulianDay(toDate)
          : FullCalender(date: toDate, timeZone: 7).julianDay;
      return numOfTDay - numOfFDay;
    } else {
      return null;
    }
  }

  /// Check if the param ```fromDate``` is before the param ```toDate```.
  /// Both [fromDate] and [toDate] need be a object of ```DateTime``` or ```LunarDateTime```.
  /// If passing another type the result will return ```null```.
  static bool? checkIsDateBefore(
      {required dynamic fromDate, required dynamic toDate}) {
    var r = _rangeDate(fromDate, toDate);
    return (r == null) ? null : (r > 0);
  }

  /// Get number of date from ```fromDate``` to ```toDate```.
  /// Both [fromDate] and [toDate] need be a object of ```DateTime``` or ```LunarDateTime```.
  /// If passing another type the result will return ```null```.
  static int? rangeOf2Dates(
      {required dynamic fromDate, required dynamic toDate}) {
    return _rangeDate(fromDate, toDate)?.abs();
  }

  /// Calculate new date
  static DateTime? _newDate(dynamic rootDate, int rangeDays) {
    if ((rootDate is DateTime || rootDate is LunarDateTime)) {
      var numOfDay = (rootDate is LunarDateTime)
          ? convertLunarDateToJulianDay(rootDate)
          : FullCalender(date: rootDate, timeZone: 7).julianDay;
      numOfDay += rangeDays;
      return convertJulianDayToSolarDate(numOfDay);
    } else {
      return null;
    }
  }

  /// Get Solar Date after ```rangeDays``` from ```fromDate```.
  /// The [fromDate] need be a object of ```DateTime``` or ```LunarDateTime```.
  /// If passing another type the result will return ```null```.
  /// You can pass the negative for date before.
  static DateTime? getSolarDateNext(
      {required dynamic fromDate, required int rangeDays}) {
    return _newDate(fromDate, rangeDays);
  }

  /// Get Lunar Date after ```rangeDays``` from ```fromDate```.
  /// The [fromDate] need be a object of ```DateTime``` or ```LunarDateTime```.
  /// If passing another type the result will return ```null```.
  /// You can pass the negative for date before.
  static LunarDateTime? getLunarDateNext(
      {required dynamic fromDate, required int rangeDays}) {
    var sld = _newDate(fromDate, rangeDays);
    return (sld == null)
        ? null
        : FullCalender(date: sld, timeZone: 7).lunarDate;
  }
}
