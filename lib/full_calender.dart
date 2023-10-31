library full_calender;

import 'dart:math';

import 'package:full_calender/lunar_date_time.dart';

class FullCalender {
  late DateTime date;

  FullCalender.now() {
    date = DateTime.now();
  }

  FullCalender({required this.date});

  int get juliusDate => _juliusDateFromSunDate(date);

  LunarDateTime get lunarDate => _convertLunarDateTime(date, 7.0);

  double get _number29th => ((5305888 / 9999999) + 29);

  int _juliusDateFromSunDate(DateTime date) {
    var a = (14 - date.month) ~/ 12;
    var y = (date.year) + 4800 - a;
    var m = date.month + 12 * a - 3;
    var jd = date.day +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045;
    if (jd < 2299161) {
      jd = date.day + (153 * m + 2) ~/ 5 + 365 * y + y ~/ 4 - 32083;
    }
    return jd;
  }

  int _getNewMoonDay(int k, double timeZone) {
    dynamic t, t2, t3, dr, jd1, M, mpr, F, c1, deltaT, newMoonDay;
    t = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    t2 = t * t;
    t3 = t2 * t;
    dr = pi / 180;
    jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * t2 - 0.000000155 * t3;
    jd1 = jd1 +
        0.00033 *
            sin((166.56 + 132.87 * t - 0.009173 * t2) * dr); // Mean new moon
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
    c1 = (0.1734 - 0.000393 * t) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    c1 = c1 - 0.4068 * sin(mpr * dr) + 0.0161 * sin(dr * 2 * mpr);
    c1 = c1 - 0.0004 * sin(dr * 3 * mpr);
    c1 = c1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + mpr));
    c1 = c1 - 0.0074 * sin(dr * (M - mpr)) + 0.0004 * sin(dr * (2 * F + M));
    c1 = c1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + mpr));
    c1 = c1 +
        0.0010 * sin(dr * (2 * F - mpr)) +
        0.0005 * sin(dr * (2 * mpr + M));
    if (t < -11) {
      deltaT = 0.001 +
          0.000839 * t +
          0.0002261 * t2 -
          0.00000845 * t3 -
          0.000000081 * t * t3;
    } else {
      deltaT = -0.000278 + 0.000265 * t + 0.000262 * t2;
    }
    newMoonDay = jd1 + c1 - deltaT;
    return (newMoonDay + 0.5 + timeZone / 24).toInt();
  }

  int _getSunLongitude(int anyJuliusDate, double timeZone) {
    dynamic t, t2, dr, m, l0, dl, l;
    t = (anyJuliusDate - 2451545.5 - timeZone / 24) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    t2 = t * t;
    dr = pi / 180; // degree to radian
    m = 357.52910 +
        35999.05030 * t -
        0.0001559 * t2 -
        0.00000048 * t * t2; // mean anomaly, degree
    l0 = 280.46645 + 36000.76983 * t + 0.0003032 * t2; // mean longitude, degree
    dl = (1.914600 - 0.004817 * t - 0.000014 * t2) * sin(dr * m);
    dl = dl +
        (0.019993 - 0.000101 * t) * sin(dr * 2 * m) +
        0.000290 * sin(dr * 3 * m);
    l = l0 + dl; // true longitude, degree
    l = l * dr;
    l = l - pi * 2 * (l ~/ (pi * 2)); // Normalize to (0, 2*PI)
    return l ~/ pi * 6;
  }

  int _getLunarMonth11(int year, double timeZone) {
    dynamic k, off, nm, sunLong;
    off = _juliusDateFromSunDate(DateTime(year, 12, 31)) - 2415021;
    k = off ~/ _number29th;
    nm = _getNewMoonDay(k, timeZone);
    sunLong = _getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = _getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  int _getLeapMonthOffset(a11, timeZone) {
    dynamic last, arc;
    int i, k = ((a11 - 2415021.076998695) / _number29th + 0.5).toInt();
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = _getSunLongitude(_getNewMoonDay(k + i, timeZone), timeZone);
    do {
      last = arc;
      i++;
      arc = _getSunLongitude(_getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc != last && i < 14);
    return i - 1;
  }

  LunarDateTime _convertLunarDateTime(DateTime dateTime, double timeZone) {
    dynamic k,
        dayNumber,
        monthStart,
        a11,
        b11,
        lunarDay,
        lunarMonth,
        lunarYear,
        lunarLeap;
    dayNumber = _juliusDateFromSunDate(dateTime);
    k = ((dayNumber - 2415021.076998695) / _number29th).toInt();
    monthStart = _getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = _getNewMoonDay(k, timeZone);
    }
    a11 = _getLunarMonth11(dateTime.year, timeZone);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = dateTime.year;
      a11 = _getLunarMonth11(dateTime.year - 1, timeZone);
    } else {
      lunarYear = dateTime.year + 1;
      b11 = _getLunarMonth11(dateTime.year + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    var diff = ((monthStart - a11) ~/ 29);
    lunarLeap = false;
    lunarMonth = diff + 12;
    if (b11 - a11 > 365) {
      var leapMonthDiff = _getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 11;
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
