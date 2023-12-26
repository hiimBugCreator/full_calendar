import 'package:flutter_test/flutter_test.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/time_zone.dart';
import 'package:full_calender/full_calender.dart';
import 'package:full_calender/models/stem_branch.dart';

void main() {
  var testTimeZone = TimeZone.vietnamese.timezone;
  test('sunDateToLunarDate1', () {
    final fCalendar =
        FullCalender(date: DateTime(2030, 2, 2), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/1/2030');
  });
  test('sunDateToLunarDate2', () {
    final fCalendar =
        FullCalender(date: DateTime(1998, 1, 27), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '30/12/1997');
  });
  test('sunDateToLunarDate3', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '13/11/2023');
  });
  test('sunDateToLunarDate4', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 12, 12), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '17/11/2000');
  });
  test('sunDateToLunarDate5', () {
    final fCalendar =
        FullCalender(date: DateTime(1977, 1, 5), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '16/11/1976');
  });
  test('sunDateToLunarDate6', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 2, 20), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/2/2023');
  });
  test('sunDateToLunarDate7', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 3, 21), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '30/2/2023');
  });
  test('sunDateToLunarDate8', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 3, 22), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/leap 2/2023');
  });
  test('sunDateToLunarDate9', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 5, 1), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '9/4/2020');
  });
  test('sunDateToLunarDate10', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 5, 31), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '9/leap 4/2020');
  });
  test('sunDateToLunarDate11', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 4, 19), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '29/leap 2/2023');
  });
  test('sunDateToLunarDate11', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 4, 20), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/3/2023');
  });

  test('nameOfYear1', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 12, 12), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Canh Thìn');
  });

  test('nameOfYear2', () {
    final fCalendar =
        FullCalender(date: DateTime(2008, 02, 15), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Mậu Tý');
  });

  test('nameOfYear3', () {
    final fCalendar =
        FullCalender(date: DateTime(2001, 10, 11), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Tân Tỵ');
  });
  test('nameOfYear4', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Quý Mão');
  });

  test('nameOfYear5', () {
    final fCalendar =
        FullCalender(date: DateTime(1995, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfYear.name(LanguageName.vietNam),
        'Ất Hợi');
  });

  test('nameOfMonth1', () {
    final stemBranch = StemBranch.month(1, 1984);
    expect(stemBranch.name(LanguageName.vietNam), 'Bính Dần');
  });

  test('nameOfMonth2', () {
    final stemBranch = StemBranch.month(1, 1989);
    expect(stemBranch.name(LanguageName.vietNam), 'Bính Dần');
  });

  test('nameOfMonth3', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfMonth.name(LanguageName.vietNam),
        'Giáp Tý');
  });

  test('nameOfDay1', () {
    final fCalendar =
        FullCalender(date: DateTime(1995, 3, 1), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfDay.name(LanguageName.vietNam),
        'Tân Mão');
  });

  test('nameOfDay2', () {
    final fCalendar =
        FullCalender(date: DateTime(1995, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfDay.name(LanguageName.vietNam),
        'Tân Mão');
  });
}
