import 'package:flutter_test/flutter_test.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/full_calender.dart';

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
  });
  test('leap2', () {
    final fCalendar = FullCalender(date: DateTime(2020, 5, 31));
    expect(fCalendar.lunarDate.toString(), '9/leap 4/2020');
  });

  test('nameOfYear1', () {
    final fCalendar = FullCalender(date: DateTime(2000, 12, 12));
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Canh Thìn');
  });

  test('nameOfYear2', () {
    final fCalendar = FullCalender(date: DateTime(2008, 02, 15));
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Mậu Tý');
  });

  test('nameOfYear3', () {
    final fCalendar = FullCalender(date: DateTime(2001, 10, 11));
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Tân Tỵ');
  });
}
