/*
 * Product by Louis Vu.
 * Astronomical algorithms from the book "Astronomical Algorithms" by Jean Meeus, 1998
 *
 * This package help you can convert between the solar and lunar calendars,
 * with a focus on the *Vietnamese lunar calendar system*.
 * In case another lunar calendar system, the results won't be absolutely perfect,
 * but this package still allows you to do that.
 * Current allowed systems are: Vietnamese, Chinese, Japanese and Korean.
 *
 * All the functions are reference this link: https://www.informatik.uni-leipzig.de/~duc/amlich/calrules.html.
 * From PhD. Ho Ngoc Duc.
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */
library full_calender;

import 'dart:math';

import 'package:full_calender/enums/solar_term.dart';
import 'package:full_calender/models/lunar_date_time.dart';

class FullCalender {
  late DateTime date;
  late int timeZone;

  final double _juliusDaysIn1900 = 2415021.076998695;
  final double _newMoonCycle = 29.530588853;

  /// This variable should be used for calculation on function.
  final int rangeDaysInYear = 365;

  FullCalender.now(int timezone) {
    date = DateTime.now();
    timeZone = timezone;
  }

  FullCalender({required this.date, required this.timeZone});

  int get julianDay => _solarDateToJulianDay(date.year, date.month, date.day);

  SolarTerm get solarTerm => _getSolarTerm(julianDay);

  LunarDateTime get lunarDate =>
      _convertSolarDateToLunarDate(date.year, date.month, date.day);

  /// Compute the Julian day number of day dd/mm/yyyy, i.e., the number
  /// of days between 1/1/4713 BC (Julian calendar) and dd/mm/yyyy.
  /// Formula from http://www.tondering.dk/claus/calendar.html
  int _solarDateToJulianDay(int yy, int mm, int dd) {
    int a, y, m, jd;
    a = ((14 - mm) / 12).floor();
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd +
        ((153 * m + 2) / 5).floor() +
        rangeDaysInYear * y +
        (y / 4).floor() -
        (y / 100).floor() +
        (y / 400).floor() -
        32045;
    if (jd < 2299161) {
      jd = dd +
          ((153 * m + 2) / 5).floor() +
          rangeDaysInYear * y +
          (y / 4).floor() -
          32083;
    }
    return jd;
  }

  /// Compute the time of the k-th new moon after the new moon of 1/1/1900 13:52 UCT
  /// (measured as the number of days since 1/1/4713 BC noon UCT, e.g., 2451545.125 is 1/1/2000 15:00 UTC).
  /// Returns a floating number, e.g., 2415079.9758617813 for k=2 or 2414961.935157746 for k=-2
  /// Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998.
  double _calculateTheNewMoon(int k) {
    double T, t2, t3, dr, jd1, M, mpr, F, c1, delta, jdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    t2 = T * T;
    t3 = t2 * T;
    dr = pi / 180;
    jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
    jd1 = jd1 +
        0.00033 *
            sin((166.56 + 132.87 * T - 0.009173 * t2) * dr); // Mean new moon
    M = 359.2242 +
        29.10535608 * k -
        0.0000333 * t2 -
        0.00000347 * t3; // Sun's mean anomaly
    mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * t2 +
        0.00001236 * t3; // Moon's mean anomaly
    F = 21.2964 +
        390.67050646 * k -
        0.0016528 * t2 -
        0.00000239 * t3; // Moon's argument of latitude
    c1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr);
    c1 = c1 - 0.0004 * sin(dr * 3 * mpr);
    c1 = c1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + mpr));
    c1 = c1 - 0.0074 * sin(dr * (M - mpr)) + 0.0004 * sin(dr * (2 * F + M));
    c1 = c1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + mpr));
    c1 = c1 +
        0.0010 * sin(dr * (2 * F - mpr)) +
        0.0005 * sin(dr * (2 * mpr + M));
    if (T < -11) {
      delta = 0.001 +
          0.000839 * T +
          0.0002261 * t2 -
          0.00000845 * t3 -
          0.000000081 * T * t3;
    } else {
      delta = -0.000278 + 0.000265 * T + 0.000262 * t2;
    }
    jdNew = jd1 + c1 - delta;
    return jdNew;
  }

  /// Compute the longitude of the sun at any time.
  /// Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
  /// Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998.
  double _calculateTheSunLongitude(double jdn) {
    double T, t2, dr, M, l0, dl, L;
    T = (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    t2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 +
        35999.05030 * T -
        0.0001559 * t2 -
        0.00000048 * T * t2; // mean anomaly, degree
    l0 = 280.46645 + 36000.76983 * T + 0.0003032 * t2; // mean longitude, degree
    dl = (1.914600 - 0.004817 * T - 0.000014 * t2) * sin(dr * M);
    dl = dl +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    L = l0 + dl; // true longitude, degree
    L = L * dr;
    L = L - pi * 2 * (L / (pi * 2)).floor(); // Normalize to (0, 2*PI)
    return L;
  }

  /// Compute sun position at midnight of the day with the given Julian day number.
  /// The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
  /// The function returns a number between 0 and 11.
  /// From the day after March equinox and the 1st major term after March equinox, 0 is returned.
  /// After that, return 1, 2, 3 ...
  double _getSunLongitude(int dayNumber) {
    return (_calculateTheSunLongitude(dayNumber - 0.5 - timeZone / 24) /
        pi *
        6);
  }

  int _getSunLongitudeFloored(int dayNumber) {
    return _getSunLongitude(dayNumber).floor();
  }

  SolarTerm _getSolarTerm(jd) {
    return SolarTerm.values[((_getSunLongitude(jd + 1) * 2).floor() + 3) % 24];
  }

  /// Compute the day of the k-th new moon in the given time zone.
  /// The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
  int getNewMoonDay(int k, int timeZone) {
    return (_calculateTheNewMoon(k) + 0.5 + timeZone / 24).floor();
  }

  /// Find the day that starts the lunar month 11 of the given year for the given time zone.
  int getLunarMonth11(int yy, [int? tz]) {
    int k, nm, sunLong;
    double off;
    off = _solarDateToJulianDay(yy, 12, 31) - 2415021;
    k = (off / _newMoonCycle).floor();
    nm = getNewMoonDay(k, tz ?? timeZone);
    sunLong = _getSunLongitudeFloored(nm);
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, tz ?? timeZone);
    }
    return nm;
  }

  /// Find the index of the leap month after the month starting on the day a11.
  int getLeapMonthOffset(int a11, [int? tz]) {
    int k, last, arc, i;
    k = ((a11 - _juliusDaysIn1900) / _newMoonCycle + 0.5).floor();
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = _getSunLongitudeFloored(getNewMoonDay(k + i, tz ?? timeZone));
    do {
      last = arc;
      i++;
      arc = _getSunLongitudeFloored(getNewMoonDay(k + i, tz ?? timeZone));
    } while (arc != last && i < 14);
    return i - 1;
  }

  /// Convert solar date dd/mm/yyyy to the corresponding lunar date.
  LunarDateTime _convertSolarDateToLunarDate(
    int yy,
    int mm,
    int dd,
  ) {
    int k, dayNumber, monthStart, a11, b11, lunarDay, lunarMonth, lunarYear;
    bool lunarLeap;
    dayNumber = _solarDateToJulianDay(yy, mm, dd);
    k = (dayNumber - _juliusDaysIn1900) ~/ _newMoonCycle;
    monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }
    a11 = getLunarMonth11(yy);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1);
    } else {
      lunarYear = yy + 1;
      b11 = getLunarMonth11(yy + 1);
    }
    lunarDay = dayNumber - monthStart + 1;
    int diff = (monthStart - a11) ~/ 29;
    lunarLeap = false;
    lunarMonth = diff + 11;
    if (b11 - a11 > rangeDaysInYear) {
      int leapMonthDiff = getLeapMonthOffset(a11);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = true;
        }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    return LunarDateTime(
        year: lunarYear, month: lunarMonth, day: lunarDay, isLeap: lunarLeap);
  }
}
