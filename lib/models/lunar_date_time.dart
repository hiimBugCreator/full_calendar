/*
 * Product by Louis Vu.
 *
 * This class provide the lunar date with some detail properties like Stem-Branch(Can-Chi/ganzhi).
 * Current allowed systems are: Vietnamese, Chinese, Japanese and Korean.
 *
 * All functions were developed by Louis Vu, and refer to the calculations at these links:
 * https://vi.wikipedia.org/wiki/Can_Chi
 *
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */

import 'package:full_calender/enums/branch.dart';
import 'package:full_calender/full_calender_extension.dart';
import 'package:full_calender/models/stem_branch.dart';

class LunarDateTime {
  final int year;
  final int month;
  final int day;
  final bool isLeap;
  final int timeZone;

  LunarDateTime(
      {required this.year,
      required this.month,
      required this.day,
      this.isLeap = false,
      this.timeZone = 7});

  StemBranch get stemBranchOfYear => StemBranch.year(year);

  StemBranch get stemBranchOfMonth => StemBranch.month(month, year);

  StemBranch get stemBranchOfDay =>
      StemBranch.day(FullCalenderExtension.convertLunarDateToJulianDay(this));

  List<StemBranch> get listStemBranchOfHour {
    List<StemBranch> listHours = List.generate(
        12,
        (index) => StemBranch.hour(
            FullCalenderExtension.convertLunarDateToJulianDay(this), index));
    return listHours;
  }

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
