/*
 * Product by Louis Vu.
 *
 * This class provide the solar term - which are 24 special points
 * in the Earth's orbit around the Sun, each point 15° apart.
 *
 * Current allowed systems are: Vietnamese, Chinese, Japanese and Korean.
 *
 * All functions were developed by Louis Vu
 * Following the knowledge on wiki site: https://en.wikipedia.org/wiki/
 *
 * Permission to use, copy, modify, and redistribute this software and its
 * documentation for personal, non-commercial use is hereby granted provided that
 * this copyright notice and appropriate documentation appears in all copies.
 */

///This class provide the solar term - which are 24 special points
///in the Earth's orbit around the Sun, each point 15° apart.
enum SolarTerm {
  springCommences,
  rainWater,
  insectsWaken,
  vernalEquinox,
  pureBrightness,
  grainRain,
  summerCommences,
  grainBuds,
  grainInEar,
  summerSolstice,
  moderateHeat,
  majorHeat,
  autumnCommences,
  endOfHeat,
  whiteDew,
  autumnalEquinox,
  coldDew,
  descentFrost,
  winterCommences,
  minorSnow,
  majorSnow,
  winterSolstice,
  moderateCold,
  majorCold
}

extension SolarTermName on SolarTerm {

  ///Get name of this solar term in Vietnamese
  String get vietnameseName {
    return switch (this) {
      SolarTerm.springCommences => "Lập Xuân",
      SolarTerm.rainWater => "Vũ Thủy",
      SolarTerm.insectsWaken => "Kinh Trập",
      SolarTerm.vernalEquinox => "Xuân Phân",
      SolarTerm.pureBrightness => "Thanh Minh",
      SolarTerm.grainRain => "Cốc Vũ",
      SolarTerm.summerCommences => "Lập Hạ",
      SolarTerm.grainBuds => "Tiểu Mãn",
      SolarTerm.grainInEar => "Mang Chủng",
      SolarTerm.summerSolstice => "Hạ Chí",
      SolarTerm.moderateHeat => "Tiểu Thử",
      SolarTerm.majorHeat => "Đại Thử",
      SolarTerm.autumnCommences => "Lập Thu",
      SolarTerm.endOfHeat => "Xử Thử",
      SolarTerm.whiteDew => "Bạch Lộ",
      SolarTerm.autumnalEquinox => "Thu Phân",
      SolarTerm.coldDew => "Hàn Lộ",
      SolarTerm.descentFrost => "Sương Giáng",
      SolarTerm.winterCommences => "Lập Đông",
      SolarTerm.minorSnow => "Tiểu Tuyết",
      SolarTerm.majorSnow => "Đại Tuyết",
      SolarTerm.winterSolstice => "Đông Chí",
      SolarTerm.moderateCold => "Tiểu Hàn",
      SolarTerm.majorCold => "Đại Hàn",
    };
  }

  ///Get name of this solar term in korean by Hangul
  String get koreanNameOnHangul {
    return switch (this) {
      SolarTerm.springCommences => "입춘",
      SolarTerm.rainWater => "우수",
      SolarTerm.insectsWaken => "경칩",
      SolarTerm.vernalEquinox => "춘분",
      SolarTerm.pureBrightness => "청명",
      SolarTerm.grainRain => "곡우",
      SolarTerm.summerCommences => "입하",
      SolarTerm.grainBuds => "소만",
      SolarTerm.grainInEar => "망종",
      SolarTerm.summerSolstice => "하지",
      SolarTerm.moderateHeat => "소서",
      SolarTerm.majorHeat => "대서",
      SolarTerm.autumnCommences => "입추",
      SolarTerm.endOfHeat => "처서",
      SolarTerm.whiteDew => "백로",
      SolarTerm.autumnalEquinox => "추분",
      SolarTerm.coldDew => "한로",
      SolarTerm.descentFrost => "상강",
      SolarTerm.winterCommences => "입동",
      SolarTerm.minorSnow => "소설",
      SolarTerm.majorSnow => "대설",
      SolarTerm.winterSolstice => "동지",
      SolarTerm.moderateCold => "소한",
      SolarTerm.majorCold => "대한",
    };
  }

  ///Get name of this solar term in Korean by Latin letters.
  String get koreanNameOnRomany {
    return switch (this) {
      SolarTerm.springCommences => "ipchun",
      SolarTerm.rainWater => "usu",
      SolarTerm.insectsWaken => "gyeongchip",
      SolarTerm.vernalEquinox => "chunbun",
      SolarTerm.pureBrightness => "cheongmyeong",
      SolarTerm.grainRain => "gogu",
      SolarTerm.summerCommences => "ipha",
      SolarTerm.grainBuds => "soman",
      SolarTerm.grainInEar => "mangjong",
      SolarTerm.summerSolstice => "haji",
      SolarTerm.moderateHeat => "soseo",
      SolarTerm.majorHeat => "daeseo",
      SolarTerm.autumnCommences => "ipchu",
      SolarTerm.endOfHeat => "cheoseo",
      SolarTerm.whiteDew => "baekno",
      SolarTerm.autumnalEquinox => "chubun",
      SolarTerm.coldDew => "hanlo",
      SolarTerm.descentFrost => "sanggang",
      SolarTerm.winterCommences => "ipdong",
      SolarTerm.minorSnow => "soseol",
      SolarTerm.majorSnow => "daeseol",
      SolarTerm.winterSolstice => "dongji",
      SolarTerm.moderateCold => "sohan",
      SolarTerm.majorCold => "daehan",
    };
  }

  ///Get name of this solar term in Japanese.
  String get japaneseName {
    return switch (this) {
      SolarTerm.springCommences => "りっしゅん",
      SolarTerm.rainWater => "うすい",
      SolarTerm.insectsWaken => "けいちつ",
      SolarTerm.vernalEquinox => "しゅんぶん",
      SolarTerm.pureBrightness => "せいめい",
      SolarTerm.grainRain => "こくう",
      SolarTerm.summerCommences => "りっか",
      SolarTerm.grainBuds => "しょうまん",
      SolarTerm.grainInEar => "ぼうしゅ",
      SolarTerm.summerSolstice => "げし",
      SolarTerm.moderateHeat => "しょうしょ",
      SolarTerm.majorHeat => "たいしょ",
      SolarTerm.autumnCommences => "りっしゅう",
      SolarTerm.endOfHeat => "しょしょ",
      SolarTerm.whiteDew => "はくろ",
      SolarTerm.autumnalEquinox => "しゅうぶん",
      SolarTerm.coldDew => "かんろ",
      SolarTerm.descentFrost => "そうこう",
      SolarTerm.winterCommences => "りっとう",
      SolarTerm.minorSnow => "しょうせつ",
      SolarTerm.majorSnow => "たいせつ",
      SolarTerm.winterSolstice => "とうじ",
      SolarTerm.moderateCold => "しょうかん",
      SolarTerm.majorCold => "だいかん",
    };
  }

  ///Get name of this solar term in Japanese by Latin letters.
  String get japaneseNameOnRomany {
    return switch (this) {
      SolarTerm.springCommences => "risshun",
      SolarTerm.rainWater => "usui",
      SolarTerm.insectsWaken => "keichitsu",
      SolarTerm.vernalEquinox => "shunbun",
      SolarTerm.pureBrightness => "seimei",
      SolarTerm.grainRain => "kokuu",
      SolarTerm.summerCommences => "rikka",
      SolarTerm.grainBuds => "shōman",
      SolarTerm.grainInEar => "bōshu",
      SolarTerm.summerSolstice => "geshi",
      SolarTerm.moderateHeat => "shōsho",
      SolarTerm.majorHeat => "taisho",
      SolarTerm.autumnCommences => "risshū",
      SolarTerm.endOfHeat => "shosho",
      SolarTerm.whiteDew => "hakuro",
      SolarTerm.autumnalEquinox => "shūbun",
      SolarTerm.coldDew => "kanro",
      SolarTerm.descentFrost => "sōkō",
      SolarTerm.winterCommences => "rittō",
      SolarTerm.minorSnow => "shōsetsu",
      SolarTerm.majorSnow => "taisetsu",
      SolarTerm.winterSolstice => "tōji",
      SolarTerm.moderateCold => "shōkan",
      SolarTerm.majorCold => "daikan",
    };
  }

  ///Get name of this solar term in Chinese
  String get baseName {
    return switch (this) {
      SolarTerm.springCommences => "立春",
      SolarTerm.rainWater => "雨水",
      SolarTerm.insectsWaken => "驚蟄",
      SolarTerm.vernalEquinox => "春分",
      SolarTerm.pureBrightness => "清明",
      SolarTerm.grainRain => "穀雨",
      SolarTerm.summerCommences => "立夏",
      SolarTerm.grainBuds => "小滿",
      SolarTerm.grainInEar => "芒種",
      SolarTerm.summerSolstice => "夏至",
      SolarTerm.moderateHeat => "小暑",
      SolarTerm.majorHeat => "大暑",
      SolarTerm.autumnCommences => "立秋",
      SolarTerm.endOfHeat => "處暑",
      SolarTerm.whiteDew => "白露",
      SolarTerm.autumnalEquinox => "秋分",
      SolarTerm.coldDew => "寒露",
      SolarTerm.descentFrost => "霜降",
      SolarTerm.winterCommences => "立冬",
      SolarTerm.minorSnow => "小雪",
      SolarTerm.majorSnow => "大雪",
      SolarTerm.winterSolstice => "冬至",
      SolarTerm.moderateCold => "小寒",
      SolarTerm.majorCold => "大寒",
    };
  }

  ///Get name of this solar term in Chinese by Latin letters.
  String get baseNameOnRomany {
    return switch (this) {
      SolarTerm.springCommences => "lìchūn",
      SolarTerm.rainWater => "yǔshuǐ",
      SolarTerm.insectsWaken => "jīngzhé",
      SolarTerm.vernalEquinox => "chūnfēn",
      SolarTerm.pureBrightness => "qīngmíng",
      SolarTerm.grainRain => "gǔyǔ",
      SolarTerm.summerCommences => "lìxià",
      SolarTerm.grainBuds => "xiǎomǎn",
      SolarTerm.grainInEar => "mángzhòng",
      SolarTerm.summerSolstice => "xiàzhì",
      SolarTerm.moderateHeat => "xiǎoshǔ",
      SolarTerm.majorHeat => "dàshǔ",
      SolarTerm.autumnCommences => "lìqiū",
      SolarTerm.endOfHeat => "chǔshǔ",
      SolarTerm.whiteDew => "báilù",
      SolarTerm.autumnalEquinox => "qiūfēn",
      SolarTerm.coldDew => "hánlù",
      SolarTerm.descentFrost => "shuāngjiàng",
      SolarTerm.winterCommences => "lìdōng",
      SolarTerm.minorSnow => "xiǎoxuě",
      SolarTerm.majorSnow => "dàxuě",
      SolarTerm.winterSolstice => "dōngzhì",
      SolarTerm.moderateCold => "xiǎohán",
      SolarTerm.majorCold => "dàhán",
    };
  }
}