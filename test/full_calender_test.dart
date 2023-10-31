import 'package:flutter_test/flutter_test.dart';
import 'package:full_calender/full_calender.dart';
import 'package:full_calender/full_calender_extension.dart';

void main() {
  test('sunDateToJuliusDate', () {
    final fCalendar = FullCalender(date: DateTime(2000,1,1));
    expect(fCalendar.juliusDate, 2451545);
  });
  test('sunDateToLunarDate', () {
    final fCalendar = FullCalender(date: DateTime(1998,3,19));
    expect(fCalendar.lunarDate.toString(), '21/2/1998');
  });
  test('leap1', () {
    final fCalendar = FullCalender(date: DateTime(2020,5,1));
    expect(fCalendar.lunarDate.toString(), '9/4/2020');
  });
  test('leap2', () {
    final fCalendar = FullCalender(date: DateTime(2020, 5, 31));
    expect(fCalendar.lunarDate.toString(), '9/leap 4/2020');
  });
}
