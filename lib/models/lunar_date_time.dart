/*
 * Product by Louis Vu.
 *
 * This class provide the lunar date with some detail properties like Stem-Branch(Can-Chi/ganzhi).
 * Current allowed systems are: Vietnamese, Chinese, Japanese and Korean.
 *
 * All functions were developed by Louis Vu, and refer to the calculations at these links:
 * https://vi.wikipedia.org/wiki/Can_Chi
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */

import 'package:full_calender/enums/branch.dart';
import 'package:full_calender/full_calender_extension.dart';
import 'package:full_calender/models/stem_branch.dart';

/// Represents a date and time in the Lunar calendar.
///
/// This class provides methods to work with Lunar dates, such as obtaining the Stem-Branch combination
/// for the year, month, day, and hours, checking lucky hours, checking if it's a lucky day, and more.
///
/// Example usage:
/// ```dart
/// LunarDateTime lunarDate = LunarDateTime(year: 2000, month: 12, day: 12);
/// print('Stem-Branch of the year: ${lunarDate.stemBranchOfYear.name(LanguageName.vietnamese)}');
/// print('Stem-Branch of the month: ${lunarDate.stemBranchOfMonth.name(LanguageName.vietnamese)}');
/// print('Stem-Branch of the day: ${lunarDate.stemBranchOfDay.name(LanguageName.vietnamese)}');
/// print('Stem-Branch of "Mouse hour": ${lunarDate.listStemBranchOfHour[0].name(LanguageName.vietnamese)}');
/// print('List of lucky hours: ${lunarDate.listLuckyHours}');
/// print('Is it a lucky day? ${lunarDate.isLuckyDay}');
/// ```
class LunarDateTime {
  final int year;
  final int month;
  final int day;
  final bool isLeap;
  final int timeZone;

  /// Constructs a LunarDateTime with the provided year, month, day, leap status, and timeZone.
  LunarDateTime(
      {required this.year,
      required this.month,
      required this.day,
      this.isLeap = false,
      this.timeZone = 7});

  /// Gets the Stem-Branch combination for the year.
  StemBranch get stemBranchOfYear => StemBranch.year(year);

  /// Gets the Stem-Branch combination for the month.
  StemBranch get stemBranchOfMonth => StemBranch.month(month, year);

  /// Gets the Stem-Branch combination for the day.
  StemBranch get stemBranchOfDay => StemBranch.dayFromLunar(this);

  /// Generates a list of Stem-Branch combinations for each hour of this date.
  /// This list has 12 elements equivalent to 12 branches from Mouse to Pig.
  List<StemBranch> get listStemBranchOfHour {
    List<StemBranch> listHours =
        List.generate(12, (index) => StemBranch.hour(this, index));
    return listHours;
  }

  /// Generates a list of lucky hours of this date.
  List<bool> get listLuckyHours {
    var jd = FullCalenderExtension.convertLunarDateToJulianDay(this);
    var num = (jd + 1) % 12;
    final List<int> louisSequence = _convertToLouisSequence(num);
    var isLucky =
        (num == 0 || num == 2 || num == 3 || num == 6 || num == 7 || num == 9);
    List<bool> listLucky = [];
    for (var i in louisSequence) {
      var temp = i;
      while (temp > 0) {
        listLucky.add(isLucky);
        temp--;
      }
      isLucky = !isLucky;
    }
    return listLucky;
  }

  bool get isLuckyDay {
    var checkMonth = (month - 1) % 6;
    var branchOfDay = stemBranchOfDay.branch;
    final List<int> louisSequence = _convertToLouisSequence(2);
    final List<Branch> orderedBranch =
        _orderedBranchToCheckLuckyDay(checkMonth);
    var isLucky = true;
    var result = false;
    var index = 0;
    for (var element in louisSequence) {
      while (element > 0) {
        if (orderedBranch[index] == branchOfDay) {
          result = isLucky;
        }
        index++;
        element--;
      }
      isLucky = !isLucky;
    }
    return result;
  }

  List<Branch> _orderedBranchToCheckLuckyDay(int index) {
    var base = [
      Branch.rat,
      Branch.ox,
      Branch.tiger,
      Branch.rabbit,
      Branch.dragon,
      Branch.snake,
      Branch.horse,
      Branch.goat,
      Branch.monkey,
      Branch.rooster,
      Branch.dog,
      Branch.pig
    ];
    while (index > 0) {
      base = base.reversed.toList();
      base.insert(0, base.removeLast());
      base.insert(0, base.removeLast());
      base = base.reversed.toList();
      index--;
    }
    return base;
  }

  List<int> _convertToLouisSequence(int index) {
    var base = [2, 1, 1, 2, 1, 1, 2, 2];
    index %= 6;
    var time = 0;
    while (index > 0) {
      base.insert(0, base.removeLast());
      if (time == 2 || time == 4) {
        base.insert(0, base.removeLast());
      }
      index--;
      time++;
    }
    return base;
  }

  @override
  String toString() {
    return '$day/${isLeap ? 'leap ' : ''}$month/$year';
  }
}
