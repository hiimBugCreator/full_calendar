/*
 * Product by Louis Vu.
 * Astronomical algorithms from the book "Astronomical Algorithms" by Jean Meeus, 1998
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */
library full_calender;

import 'dart:math';

import 'package:full_calender/lunar_date_time.dart';

class FullCalender {
  late DateTime date;

  FullCalender.now() {
    date = DateTime.now();
  }

  FullCalender({required this.date});

  int get juliusDate => _jdFromDate(date.day, date.month, date.year);

  LunarDateTime get lunarDate =>
      _convertSolarDateToLunarDate(date.day, date.month, date.year, 7.0);

  /* Discard the fractional part of a number, e.g., INT(3.2) = 3 */
  _int(double d) => d.toInt();

  // Compute the (integral) Julian day number of day dd/mm/yyyy, i.e., the number
  // of days between 1/1/4713 BC (Julian calendar) and dd/mm/yyyy.
  // Formula from http://www.tondering.dk/claus/calendar.html
  _jdFromDate(dd, mm, yy) {
    var a, y, m, jd;
    a = _int((14 - mm) / 12);
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd +
        _int((153 * m + 2) / 5) +
        365 * y +
        _int(y / 4) -
        _int(y / 100) +
        _int(y / 400) -
        32045;
    if (jd < 2299161) {
      jd = dd + _int((153 * m + 2) / 5) + 365 * y + _int(y / 4) - 32083;
    }
    return jd;
  }

  /* Compute the time of the k-th new moon after the new moon of 1/1/1900 13:52 UCT
 * (measured as the number of days since 1/1/4713 BC noon UCT, e.g., 2451545.125 is 1/1/2000 15:00 UTC).
 * Returns a floating number, e.g., 2415079.9758617813 for k=2 or 2414961.935157746 for k=-2
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
  NewMoon(k) {
    var T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat, JdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = pi / 180;
    Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 = Jd1 +
        0.00033 *
            sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    M = 359.2242 +
        29.10535608 * k -
        0.0000333 * T2 -
        0.00000347 * T3; // Sun's mean anomaly
    Mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * T2 +
        0.00001236 * T3; // Moon's mean anomaly
    F = 21.2964 +
        390.67050646 * k -
        0.0016528 * T2 -
        0.00000239 * T3; // Moon's argument of latitude
    C1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr);
    C1 = C1 - 0.0004 * sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 = C1 +
        0.0010 * sin(dr * (2 * F - Mpr)) +
        0.0005 * sin(dr * (2 * Mpr + M));
    if (T < -11) {
      deltat = 0.001 +
          0.000839 * T +
          0.0002261 * T2 -
          0.00000845 * T3 -
          0.000000081 * T * T3;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    ;
    JdNew = Jd1 + C1 - deltat;
    return JdNew;
  }

  /* Compute the longitude of the sun at any time.
 * Parameter: floating number jdn, the number of days since 1/1/4713 BC noon
 * Algorithm from: "Astronomical Algorithms" by Jean Meeus, 1998
 */
  SunLongitude(jdn) {
    var T, T2, dr, M, L0, DL, L;
    T = (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 +
        35999.05030 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    L = L0 + DL; // true longitude, degree
    L = L * dr;
    L = L - pi * 2 * (_int(L / (pi * 2))); // Normalize to (0, 2*PI)
    return L;
  }

  /* Compute sun position at midnight of the day with the given Julian day number.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00.
 * The  returns a number between 0 and 11.
 * From the day after March equinox and the 1st major term after March equinox, 0 is returned.
 * After that, return 1, 2, 3 ...
 */
  getSunLongitude(dayNumber, timeZone) {
    return _int(SunLongitude(dayNumber - 0.5 - timeZone / 24) / pi * 6);
  }

/* Compute the day of the k-th new moon in the given time zone.
 * The time zone if the time difference between local time and UTC: 7.0 for UTC+7:00
 */
  getNewMoonDay(k, timeZone) {
    return _int(NewMoon(k) + 0.5 + timeZone / 24);
  }

/* Find the day that starts the luner month 11 of the given year for the given time zone */
  getLunarMonth11(yy, timeZone) {
    var k, off, nm, sunLong;
    //off = _jdFromDate(31, 12, yy) - 2415021.076998695;
    off = _jdFromDate(31, 12, yy) - 2415021;
    k = _int(off / 29.530588853);
    nm = getNewMoonDay(k, timeZone);
    sunLong = getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

/* Find the index of the leap month after the month starting on the day a11. */
  getLeapMonthOffset(a11, timeZone) {
    var k, last, arc, i;
    k = _int((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    do {
      last = arc;
      i++;
      arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc != last && i < 14);
    return i - 1;
  }

/* Convert solar date dd/mm/yyyy to the corresponding lunar date */
  LunarDateTime _convertSolarDateToLunarDate(dd, mm, yy, timeZone) {
    var k,
        dayNumber,
        monthStart,
        a11,
        b11,
        lunarDay,
        lunarMonth,
        lunarYear,
        lunarLeap;
    dayNumber = _jdFromDate(dd, mm, yy);
    k = _int((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = getNewMoonDay(k + 1, timeZone);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }
    a11 = getLunarMonth11(yy, timeZone);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
      b11 = getLunarMonth11(yy + 1, timeZone);
    }
    lunarDay = dayNumber - monthStart + 1;
    var diff = _int((monthStart - a11) / 29);
    lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      var leapMonthDiff = getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff &&
            (yy % 19 == 0 ||
                yy % 19 == 3 ||
                yy % 19 == 6 ||
                yy % 19 == 9 ||
                yy % 19 == 11 ||
                yy % 19 == 14 ||
                yy % 19 == 17)) {
          lunarLeap = 1;
        } else {
          lunarMonth += 1;
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
        year: lunarYear,
        month: lunarMonth,
        day: lunarDay,
        isLeap: (lunarLeap == 1));
  }
}

// getCanChiYear(int year) {
//   var can = canList[year % 10];
//   var chi = chiList[year % 12];
//   return '${can} ${chi}';
// }
//
// getCanChiMonth(int month, int year) {
//   var chi = chiForMonthList[month - 1];
//   var indexCan = 0;
//   var can = canList[year % 10];
//
//   if (can == "Giáp" || can == "Kỉ") {
//     indexCan = 6;
//   }
//   if (can == "Ất" || can == "Canh") {
//     indexCan = 8;
//   }
//   if (can == "Bính" || can == "Tân") {
//     indexCan = 0;
//   }
//   if (can == "Đinh" || can == "Nhâm") {
//     indexCan = 2;
//   }
//   if (can == "Mậu" || can == "Quý") {
//     indexCan = 4;
//   }
//   return '${canList[(indexCan + month - 1) % 10]} ${chi}';
// }
//
// // getDayName(lunarDate) {
// //  if (lunarDate.day == 0) {
// //    return "";
// //  }
// //  var cc = getCanChi(lunarDate);
// //  var s = "Ngày " + cc[0] +", tháng "+cc[1] + ", năm " + cc[2];
// //  return s;
// //}
//
// getYearCanChi(year) {
//   return canOrderedList[(year + 6) % 10] + " " + chiOrderedList[(year + 8) % 12];
// }
//
// getCanHour(jdn) {
//   return canOrderedList[(jdn - 1) * 2 % 10];
// }
//
// getCanDay(jdn) {
//   var dayName, monthName, yearName;
//   dayName = canOrderedList[(jdn + 9) % 10] + " " + chiOrderedList[(jdn + 1) % 12];
//   return dayName;
// }
//
// jdn(dd, mm, yy) {
//   var a = int((14 - mm) / 12);
//   var y = yy + 4800 - a;
//   var m = mm + 12 * a - 3;
//   var jd = dd +
//       int((153 * m + 2) / 5) +
//       365 * y +
//       int(y / 4) -
//       int(y / 100) +
//       int(y / 400) -
//       32045;
//   return jd;
// }
//
// getGioHoangDao(jd) {
//   var chiOfDay = (jd + 1) % 12;
//   var gioHD = gioHoangDao[chiOfDay %
//       6]; // same values for Ty' (1) and Ngo. (6), for Suu and Mui etc.
//   var ret = "";
//   var count = 0;
//   for (var i = 0; i < 12; i++) {
//     if (gioHD.substring(i, i + 1) == '1') {
//       ret += chiOrderedList[i];
//       ret += ' (${{(i * 2 + 23) % 24}}-${{(i * 2 + 1) % 24}})';
//       if (count++ < 5) ret += ', ';
//       if (count == 3) ret += '\n';
//     }
//   }
//   return ret;
// }
//
// getTietKhi(jd) {
//   return tietKhiList[getSunLongitude(jd + 1, 7.0)];
// }
//
// getBeginHour(jdn) {
//   return canOrderedList[(jdn - 1) * 2 % 10] + ' ' + chiOrderedList[0];
// }
