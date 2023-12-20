/*
* Following the knowledge on wiki site: https://en.wikipedia.org/wiki/
*/
enum Stem {
  yangWood,
  yinWood,
  yangFire,
  yinFire,
  yangEarth,
  yinEarth,
  yangMetal,
  yinMetal,
  yangWater,
  yinWater,
}

extension StemName on Stem {
  String get vietnameseName {
    return switch (this) {
      Stem.yangWood => "Giáp",
      Stem.yinWood => "Ất",
      Stem.yangFire => "Bính",
      Stem.yinFire => "Đinh",
      Stem.yangEarth => "Mậu",
      Stem.yinEarth => "Kỷ",
      Stem.yangMetal => "Canh",
      Stem.yinMetal => "Tân",
      Stem.yangWater => "Nhâm",
      Stem.yinWater => "Quý"
    };
  }

  String get koreanNameOnHangul {
    return switch (this) {
      Stem.yangWood => "갑",
      Stem.yinWood => "갑",
      Stem.yangFire => "병",
      Stem.yinFire => "정",
      Stem.yangEarth => "무",
      Stem.yinEarth => "기",
      Stem.yangMetal => "경",
      Stem.yinMetal => "신	",
      Stem.yangWater => "임",
      Stem.yinWater => "계"
    };
  }

  String get koreanNameOnRomany {
    return switch (this) {
      Stem.yangWood => "gap",
      Stem.yinWood => "eul",
      Stem.yangFire => "byeong",
      Stem.yinFire => "jeong",
      Stem.yangEarth => "mu",
      Stem.yinEarth => "gi",
      Stem.yangMetal => "gyeong",
      Stem.yinMetal => "sin	",
      Stem.yangWater => "im",
      Stem.yinWater => "gye"
    };
  }

  String get japaneseKunNameOnRomany {
    return switch (this) {
      Stem.yangWood => "kinoe",
      Stem.yinWood => "kinoto",
      Stem.yangFire => "hinoe",
      Stem.yinFire => "hinoto",
      Stem.yangEarth => "tsuchinoe",
      Stem.yinEarth => "tsuchinoto",
      Stem.yangMetal => "kanoe",
      Stem.yinMetal => "kanoto	",
      Stem.yangWater => "mizunoe",
      Stem.yinWater => "mizunoto"
    };
  }

  String get japaneseKunName{
    return switch (this) {
      Stem.yangWood => "木の兄",
      Stem.yinWood => "木の弟",
      Stem.yangFire => "火の兄",
      Stem.yinFire => "火の弟",
      Stem.yangEarth => "土の兄",
      Stem.yinEarth => "土の弟",
      Stem.yangMetal => "金の兄",
      Stem.yinMetal => "金の弟	",
      Stem.yangWater => "水の兄",
      Stem.yinWater => "水の弟"
    };
  }

  String get japaneseOnNameOnRomany {
    return switch (this) {
      Stem.yangWood => "kō",
      Stem.yinWood => "otsu",
      Stem.yangFire => "hei",
      Stem.yinFire => "tei",
      Stem.yangEarth => "bo",
      Stem.yinEarth => "ki",
      Stem.yangMetal => "kō",
      Stem.yinMetal => "shin	",
      Stem.yangWater => "jin",
      Stem.yinWater => "ki"
    };
  }

  String get japaneseOnName{
    return switch (this) {
      Stem.yangWood => "こう",
      Stem.yinWood => "おつ",
      Stem.yangFire => "へい",
      Stem.yinFire => "てい",
      Stem.yangEarth => "ぼ",
      Stem.yinEarth => "き",
      Stem.yangMetal => "こう",
      Stem.yinMetal => "しん	",
      Stem.yangWater => "じん",
      Stem.yinWater => "き"
    };
  }

  String get baseName {
    return switch (this) {
      Stem.yangWood => "甲",
      Stem.yinWood => "乙",
      Stem.yangFire => "丙",
      Stem.yinFire => "丁",
      Stem.yangEarth => "戊",
      Stem.yinEarth => "己",
      Stem.yangMetal => "庚",
      Stem.yinMetal => "辛	",
      Stem.yangWater => "壬",
      Stem.yinWater => "癸"
    };
  }

  String get baseNameOnRomany{
    return switch (this) {
      Stem.yangWood => "jiǎ",
      Stem.yinWood => "yǐ",
      Stem.yangFire => "bǐng",
      Stem.yinFire => "dīng",
      Stem.yangEarth => "wù",
      Stem.yinEarth => "jǐ",
      Stem.yangMetal => "gēng",
      Stem.yinMetal => "xīn	",
      Stem.yangWater => "rén",
      Stem.yinWater => "guǐ"
    };
  }
}
