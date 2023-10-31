import 'package:full_calender/full_calender.dart';

extension FullCalenderExtension on FullCalender {
  DateTime juliusDateToSunDate(int jd) {
    int a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      a = jd + 32044;
      b = ((4 * a + 3) ~/ 146097);
      c = a - ((b * 146097) ~/ 4);
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = ((4 * c + 3) ~/ 1461);
    e = c - ((1461 * d) ~/ 4);
    m = ((5 * e + 2) ~/ 153);
    day = e - ((153 * m + 2) ~/ 5) + 1;
    month = m + 3 - 12 * (m ~/ 10);
    year = b * 100 + d - 4800 + (m ~/ 10);
    return DateTime(year, month, day);
  }
}