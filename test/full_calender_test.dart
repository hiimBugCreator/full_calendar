import 'package:flutter_test/flutter_test.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/solar_term.dart';
import 'package:full_calender/enums/time_zone.dart';
import 'package:full_calender/full_calender.dart';
import 'package:full_calender/full_calender_extension.dart';
import 'package:full_calender/models/lunar_date_time.dart';
import 'package:full_calender/models/stem_branch.dart';

void main() {
  var testTimeZone = TimeZone.vietnamese.timezone;
  test('solarDateToJulianDay', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 1, 1), timeZone: testTimeZone);
    expect(fCalendar.julianDay, 2451545);
  });
  test('lunarDateToSolarDate', () {
    final sDate = FullCalenderExtension.convertLunarDateToSolarDate(
        LunarDateTime(year: 2008, month: 9, day: 22));
    expect(sDate, DateTime(2008, 10, 20));
  });
  test('solarDateToLunarDate1', () {
    final fCalendar =
        FullCalender(date: DateTime(2030, 2, 2), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/1/2030');
  });
  test('solarDateToLunarDate2', () {
    final fCalendar =
        FullCalender(date: DateTime(1998, 1, 27), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '30/12/1997');
  });
  test('solarDateToLunarDate3', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 12, 25), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '13/11/2023');
  });
  test('solarDateToLunarDate4', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 12, 12), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '17/11/2000');
  });
  test('solarDateToLunarDate5', () {
    final fCalendar =
        FullCalender(date: DateTime(1977, 1, 5), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '16/11/1976');
  });
  test('solarDateToLunarDate6', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 2, 20), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/2/2023');
  });
  test('solarDateToLunarDate7', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 3, 21), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '30/2/2023');
  });
  test('solarDateToLunarDate8', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 3, 22), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '1/leap 2/2023');
  });
  test('solarDateToLunarDate9', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 5, 1), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '9/4/2020');
  });
  test('solarDateToLunarDate10', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 5, 31), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '9/leap 4/2020');
  });
  test('solarDateToLunarDate11', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 4, 19), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.toString(), '29/leap 2/2023');
  });
  test('solarDateToLunarDate11', () {
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
        'Canh Dần');
  });

  test('nameOfDay3', () {
    final fCalendar =
        FullCalender(date: DateTime(2008, 10, 20), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.stemBranchOfDay.name(LanguageName.vietNam),
        'Quý Tỵ');
  });

  test('listHours1', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 10), timeZone: testTimeZone);
    expect(
        fCalendar.lunarDate.listStemBranchOfHour[0].name(LanguageName.vietNam),
        'Canh Tý');
  });
  test('listHours2', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 10), timeZone: testTimeZone);
    expect(
        fCalendar.lunarDate.listStemBranchOfHour[2].name(LanguageName.vietNam),
        'Nhâm Dần');
  });
  test('listHours3', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 10), timeZone: testTimeZone);
    expect(
        fCalendar.lunarDate.listStemBranchOfHour[11].name(LanguageName.vietNam),
        'Tân Hợi');
  });
  test('listHours4', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 21), timeZone: testTimeZone);
    expect(
        fCalendar.lunarDate.listStemBranchOfHour[0].name(LanguageName.vietNam),
        'Nhâm Tý');
  });
  test('listHours5', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 21), timeZone: testTimeZone);
    expect(
        fCalendar.lunarDate.listStemBranchOfHour[11].name(LanguageName.vietNam),
        'Quý Hợi');
  });
  test('listLuckyHour1', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 11, 20), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.listLuckyHours, [
      true,
      true,
      false,
      true,
      false,
      false,
      true,
      false,
      true,
      true,
      false,
      false
    ]);
  });
  test('listLuckyHour2', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 12, 28), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.listLuckyHours, [
      false,
      true,
      false,
      false,
      true,
      false,
      true,
      true,
      false,
      false,
      true,
      true
    ]);
  });
  test('luckyDay1', () {
    final fCalendar =
        FullCalender(date: DateTime(2023, 12, 28), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.isLuckyDay, true);
  });
  test('luckyDay2', () {
    final fCalendar =
        FullCalender(date: DateTime(2020, 12, 28), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.isLuckyDay, false);
  });
  test('luckyDay3', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 12, 12), timeZone: testTimeZone);
    expect(fCalendar.lunarDate.isLuckyDay, false);
  });

  test('solarTerm1', () {
    final fCalendar =
        FullCalender(date: DateTime(2000, 12, 12), timeZone: testTimeZone);
    expect(fCalendar.solarTerm.vietnameseName, "Đại Tuyết");
  });

  test('solarTerm2', () {
    final fCalendar =
        FullCalender(date: DateTime(2024, 2, 10), timeZone: testTimeZone);
    expect(fCalendar.solarTerm.vietnameseName, "Lập Xuân");
  });

  test('countDate', () {
    final rs = FullCalenderExtension.rangeOf2Dates(
        fromDate: DateTime(2000, 12, 12),
        toDate:
            FullCalender(date: DateTime(2000, 12, 18), timeZone: 7).lunarDate);
    expect(rs, 6);
  });

  test('countDateErr', () {
    final rs = FullCalenderExtension.rangeOf2Dates(
        fromDate: DateTime(2000, 12, 12), toDate: 'Invalid type');
    expect(rs, null);
  });

  test('checkDateBefore', () {
    final rs = FullCalenderExtension.checkIsDateBefore(
        fromDate: DateTime(2000, 12, 12),
        toDate:
            FullCalender(date: DateTime(2000, 12, 18), timeZone: 7).lunarDate);
    expect(rs, true);
  });

  test('testNextDate', () {
    final rs = LunarDateTime(year: 2023, month: 2, day: 5).getDateNext(10);
    expect(
        rs.toString(), LunarDateTime(year: 2023, month: 2, day: 15).toString());
  });

  test('testBeforeDate', () {
    final rs = FullCalenderExtension.getSolarDateNext(
        fromDate: DateTime(2024, 12, 14), rangeDays: -2);
    expect(rs.toString(), DateTime(2024, 12, 12).toString());
  });
}
