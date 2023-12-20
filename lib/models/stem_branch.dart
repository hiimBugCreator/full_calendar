import 'package:full_calender/enums/branch.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/stem.dart';

class StemBranch {
  late Stem stem;
  late Branch branch;

  StemBranch({required this.stem, required this.branch});

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
