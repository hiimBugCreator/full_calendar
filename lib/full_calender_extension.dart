import 'package:full_calender/full_calender.dart';

extension FullCalenderExtension on FullCalender {
  /* Discard the fractional part of a number, e.g., INT(3.2) = 3 */
  _int(double d) => d.toInt();

  /* Convert a Julian day number to day/month/year. Parameter jd is an integer */
  DateTime jdToDate(jd) {
    dynamic a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      // After 5/10/1582, Gregorian calendar
      a = jd + 32044;
      b = _int((4 * a + 3) / 146097);
      c = a - _int((b * 146097) / 4);
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = _int((4 * c + 3) / 1461);
    e = c - _int((1461 * d) / 4);
    m = _int((5 * e + 2) / 153);
    day = e - _int((153 * m + 2) / 5) + 1;
    month = m + 3 - 12 * _int(m / 10);
    year = b * 100 + d - 4800 + _int(m / 10);
    return DateTime(year, month, day);
  }

  /* Convert a lunar date to the corresponding solar date */
  DateTime convertLunar2Solar(
      lunarDay, lunarMonth, lunarYear, lunarLeap, timeZone) {
    dynamic k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarMonth < 11) {
      a11 = getLunarMonth11(lunarYear - 1, timeZone);
      b11 = getLunarMonth11(lunarYear, timeZone);
    } else {
      a11 = getLunarMonth11(lunarYear, timeZone);
      b11 = getLunarMonth11(lunarYear + 1, timeZone);
    }
    k = _int(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      leapOff = getLeapMonthOffset(a11, timeZone);
      leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        return DateTime(0, 0, 0);
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    monthStart = getNewMoonDay(k + off, timeZone);
    return jdToDate(monthStart + lunarDay - 1);
  }
}
