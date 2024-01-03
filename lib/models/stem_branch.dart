/*
 * Product by Louis Vu.
 *
 * This class provide 天干地支 for year, month, day, hour following the lunar date.
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
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/stem.dart';
import 'package:full_calender/full_calender_extension.dart';
import 'package:full_calender/models/lunar_date_time.dart';

///
/// Represents a combination of a Stem and a Branch
/// (People combine a stem with a branch to form the official name of things that need to be named (day, hour, month, year, etc.)).
///
/// This class provides methods to create StemBranch instances based on the year, month, day of the [LunarDateTime].
///
/// Example usage:
/// ```dart
/// // Create a StemBranch for the year 2022
/// StemBranch yearBranch = StemBranch.year(2022);
/// print('Year Branch: ${yearBranch.name(LanguageName.vietnamese)}');
///
/// // Create a StemBranch for the month of December in the year 2000
/// StemBranch monthBranch = StemBranch.month(12, 2000);
/// print('Month Branch: ${monthBranch.name(LanguageName.vietnamese)}');
/// ```
class StemBranch {
  late Stem stem;
  late Branch branch;

  /// Constructs a StemBranch with the provided Stem and Branch.
  StemBranch({required this.stem, required this.branch});

  /// Creates a year's StemBranch instance based on the given this [year].
  factory StemBranch.year(int year) {
    final stemsYearOrdered = [
      Stem.yangMetal,
      Stem.yinMetal,
      Stem.yangWater,
      Stem.yinWater,
      Stem.yangWood,
      Stem.yinWood,
      Stem.yangFire,
      Stem.yinFire,
      Stem.yangEarth,
      Stem.yinEarth,
    ];
    final branchesYearOrdered = [
      Branch.monkey,
      Branch.rooster,
      Branch.dog,
      Branch.pig,
      Branch.rat,
      Branch.ox,
      Branch.tiger,
      Branch.rabbit,
      Branch.dragon,
      Branch.snake,
      Branch.horse,
      Branch.goat,
    ];
    return StemBranch(
        stem: stemsYearOrdered[year % 10],
        branch: branchesYearOrdered[year % 12]);
  }

  /// Creates a month's StemBranch instance based on the given this [month] and [year] of this [month].
  factory StemBranch.month(int month, int year) {
    final stemsYearOrdered = [
      Stem.yangMetal,
      Stem.yinMetal,
      Stem.yangWater,
      Stem.yinWater,
      Stem.yangWood,
      Stem.yinWood,
      Stem.yangFire,
      Stem.yinFire,
      Stem.yangEarth,
      Stem.yinEarth,
    ];
    final stemsJanIndexOrdered = [8, 0, 2, 4, 6, 8, 0, 2, 4, 6];
    final branchesMonthOrdered = [
      Branch.tiger,
      Branch.rabbit,
      Branch.dragon,
      Branch.snake,
      Branch.horse,
      Branch.goat,
      Branch.monkey,
      Branch.rooster,
      Branch.dog,
      Branch.pig,
      Branch.rat,
      Branch.ox,
    ];
    final stemYearIndex = year % 10;
    var steamMonthIndex =
        (stemsJanIndexOrdered[stemYearIndex] + month - 1) % 10;
    return StemBranch(
        stem: stemsYearOrdered[steamMonthIndex],
        branch: branchesMonthOrdered[month - 1]);
  }

  /// Creates a StemBranch instance based on the given the Julian day: [julianDay].
  factory StemBranch.day(int julianDay) {
    final stemsOrdered = [
      Stem.yangWood,
      Stem.yinWood,
      Stem.yangFire,
      Stem.yinFire,
      Stem.yangEarth,
      Stem.yinEarth,
      Stem.yangMetal,
      Stem.yinMetal,
      Stem.yangWater,
      Stem.yinWater,
    ];
    final branchesOrdered = [
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
      Branch.pig,
    ];
    return StemBranch(
        stem: stemsOrdered[(julianDay + 9) % 10],
        branch: branchesOrdered[(julianDay + 1) % 12]);
  }

  /// Creates a StemBranch instance based on the given the instance of LunarDateTime [date].
  factory StemBranch.dayFromLunar(LunarDateTime date) {
    return StemBranch.day(FullCalenderExtension.convertLunarDateToJulianDay(date));
  }

  /// Creates a StemBranch instance based on the given LunarDateTime [date] and [index] in range [[0-11]].
  factory StemBranch.hour(LunarDateTime date, int index) {
    final stemsOrdered = [
      Stem.yangWood,
      Stem.yinWood,
      Stem.yangFire,
      Stem.yinFire,
      Stem.yangEarth,
      Stem.yinEarth,
      Stem.yangMetal,
      Stem.yinMetal,
      Stem.yangWater,
      Stem.yinWater,
    ];
    final branchesOrdered = [
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
      Branch.pig,
    ];
    var julianDay = FullCalenderExtension.convertLunarDateToJulianDay(date);
    return StemBranch(
        stem: stemsOrdered[((julianDay - 1) * 2 + index) % 10],
        branch: branchesOrdered[index]);
  }

  /// Generates the name of the StemBranch in the specified [lang].
  String name(LanguageName lang) {
    return switch (lang) {
      LanguageName.basic => "${stem.baseName}${branch.baseName}",
      LanguageName.basicRomany =>
        "${stem.baseNameOnRomany}-${branch.baseNameOnRomany}",
      LanguageName.vietNam => "${stem.vietnameseName} ${branch.vietnameseName}",
      LanguageName.korean =>
        "${stem.koreanNameOnHangul}${branch.koreanNameOnHangul}",
      LanguageName.koreanRomany =>
        "${stem.koreanNameOnRomany}-${branch.koreanNameOnRomany}",
      LanguageName.japaneseKunyomi =>
        "${stem.japaneseKunName}${branch.japaneseKunName}",
      LanguageName.japaneseKunyomiRomany =>
        "${stem.japaneseKunNameOnRomany} ${branch.japaneseKunNameOnRomany}",
      LanguageName.japaneseOnyomi =>
        "${stem.japaneseOnName}${branch.japaneseOnName}",
      LanguageName.japaneseOnyomiRomany =>
        "${stem.japaneseOnNameOnRomany}${branch.japaneseOnNameOnRomany}",
    };
  }
}
