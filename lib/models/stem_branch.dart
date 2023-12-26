import 'package:full_calender/enums/branch.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/stem.dart';

class StemBranch {
  late Stem stem;
  late Branch branch;

  StemBranch({required this.stem, required this.branch});

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
