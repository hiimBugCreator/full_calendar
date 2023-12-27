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

import 'package:full_calender/full_calender_extension.dart';
import 'package:full_calender/models/stem_branch.dart';

class LunarDateTime {
  final _chiForMonthList = [
    "Dần",
    "Mẹo",
    "Thìn",
    "Tị",
    "Ngọ",
    "Mùi",
    "Thân",
    "Dậu",
    "Tuất",
    "Hợi",
    "Tý",
    "Sửu",
  ];
  final _canOrderedList = [
    'Giáp',
    'Ất',
    'Bính',
    'Đinh',
    'Mậu',
    'Kỷ',
    'Canh',
    'Tân',
    'Nhâm',
    'Quý'
  ];
  final _chiOrderedList = [
    'Tý',
    'Sửu',
    'Dần',
    'Mẹo',
    'Thìn',
    'Tỵ',
    'Ngọ',
    'Mùi',
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi'
  ];
  final _tietKhiList = [
    'Xuân phân',
    'Thanh minh',
    'Cốc vũ',
    'Lập hạ',
    'Tiểu mãn',
    'Mang chủng',
    'Hạ chí',
    'Tiểu thử',
    'Đại thử',
    'Lập thu',
    'Xử thử',
    'Bạch lộ',
    'Thu phân',
    'Hàn lộ',
    'Sương giáng',
    'Lập đông',
    'Tiểu tuyết',
    'Đại tuyết',
    'Đông chí',
    'Tiểu hàn',
    'Đại hàn',
    'Lập xuân',
    'Vũ thủy',
    'Kinh trập'
  ];

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
    final louisSequence = _convertToLouisSequence(num);
    var isLucky = (num == 0 ||
        num == 2 ||
        num == 3 ||
        num == 6 ||
        num == 7 ||
        num == 9);
    var index = 0;
    List<bool> listLucky = [];
    for (var i in louisSequence) {
      var temp = louisSequence[i];
      while (temp > 0) {
        listLucky[index] = isLucky;
        temp--;
        index++;
      }
      isLucky = !isLucky;
    }
    print("XXXXXXXX $listLucky");
    return listLucky;
  }

  List<int> _convertToLouisSequence(int index) {
    var base = [2, 1, 1, 2, 1, 1, 2, 2];
    index %= 6;
    while (index > 0) {
      base.insert(0, base.removeLast());
      index--;
    }
    return base;
  }

  @override
  String toString() {
    return '$day/${isLeap ? 'leap ' : ''}$month/$year';
  }
}
