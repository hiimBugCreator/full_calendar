import 'package:flutter_test/flutter_test.dart';
import 'package:full_calender/full_calender.dart';
import 'package:full_calender/full_calender_extension.dart';

void main() {
  test('sunDateToJuliusDate', () {
    final fCalendar = FullCalender(date: DateTime(2000, 1, 1));
    expect(fCalendar.juliusDate, 2451545);
  });
  test('sunDateToLunarDate', () {
    final fCalendar = FullCalender(date: DateTime(1997, 12, 29));
    expect(fCalendar.lunarDate.toString(), '1/12/1997');
  });
  test('sunDateToLunarDate2', () {
    final fCalendar = FullCalender(date: DateTime(2000, 12, 12));
    expect(fCalendar.lunarDate.toString(), '17/11/2000');
  });
  test('sunDateToLunarDate3', () {
    final fCalendar = FullCalender(date: DateTime(1977, 1, 5));
    expect(fCalendar.lunarDate.toString(), '16/11/1976');
  });
  test('leap1', () {
    final fCalendar = FullCalender(date: DateTime(2020, 5, 1));
    expect(fCalendar.lunarDate.toString(), '9/4/2020');
    // expect(_convertSolarDateToLunarDate(1,5,2020,7.0), [9, 4, 2020, false]);
  });
  test('leap2', () {
    final fCalendar = FullCalender(date: DateTime(2020, 5, 31));
    expect(fCalendar.lunarDate.toString(), '9/leap 4/2020');
  });
}
