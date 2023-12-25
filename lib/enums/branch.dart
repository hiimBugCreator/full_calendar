/*
* Following the knowledge on wiki site: https://en.wikipedia.org/wiki/
*/
enum Branch {
  rat,
  ox,
  tiger,
  rabbit,
  dragon,
  snake,
  horse,
  goat,
  monkey,
  rooster,
  dog,
  pig
}

extension BranchName on Branch {
  String get vietnameseName {
    return switch (this) {
      Branch.rat => "Tý",
      Branch.ox => "Sửu",
      Branch.tiger => "Dần",
      Branch.rabbit => "Mão",
      Branch.dragon => "Thìn",
      Branch.snake => "Tỵ",
      Branch.horse => "Ngọ",
      Branch.goat => "Mùi",
      Branch.monkey => "Thân",
      Branch.rooster => "Dậu",
      Branch.dog => "Tuất",
      Branch.pig => "Hợi",
    };
  }

  String get koreanNameOnRomany {
    return switch (this) {
      Branch.rat => "ja",
      Branch.ox => "chuk",
      Branch.tiger => "in",
      Branch.rabbit => "myo",
      Branch.dragon => "jin",
      Branch.snake => "sa",
      Branch.horse => "o",
      Branch.goat => "mi",
      Branch.monkey => "sin",
      Branch.rooster => "yu",
      Branch.dog => "sul",
      Branch.pig => "hae",
    };
  }

  String get koreanNameOnHangul {
    return switch (this) {
      Branch.rat => "ja",
      Branch.ox => "chuk",
      Branch.tiger => "in",
      Branch.rabbit => "myo",
      Branch.dragon => "jin",
      Branch.snake => "sa",
      Branch.horse => "o",
      Branch.goat => "mi",
      Branch.monkey => "sin",
      Branch.rooster => "yu",
      Branch.dog => "sul",
      Branch.pig => "hae",
    };
  }

  String get japaneseKunNameOnRomany {
    return switch (this) {
      Branch.rat => "ne",
      Branch.ox => "ushi",
      Branch.tiger => "tora",
      Branch.rabbit => "u",
      Branch.dragon => "tatsu",
      Branch.snake => "mi",
      Branch.horse => "uma",
      Branch.goat => "hitsuji",
      Branch.monkey => "saru",
      Branch.rooster => "tori",
      Branch.dog => "inu",
      Branch.pig => "i",
    };
  }

  String get japaneseKunName {
    return switch (this) {
      Branch.rat => "ね",
      Branch.ox => "うし",
      Branch.tiger => "とら",
      Branch.rabbit => "う",
      Branch.dragon => "たつ",
      Branch.snake => "み",
      Branch.horse => "うま",
      Branch.goat => "ひつじ",
      Branch.monkey => "さる",
      Branch.rooster => "とり",
      Branch.dog => "いぬ",
      Branch.pig => "い",
    };
  }

  String get japaneseOnNameOnRomany {
    return switch (this) {
      Branch.rat => "shi",
      Branch.ox => "chū",
      Branch.tiger => "in",
      Branch.rabbit => "bō",
      Branch.dragon => "shin",
      Branch.snake => "shi",
      Branch.horse => "go",
      Branch.goat => "bi",
      Branch.monkey => "shin",
      Branch.rooster => "yū",
      Branch.dog => "jutsu",
      Branch.pig => "gai",
    };
  }

  String get japaneseOnName {
    return switch (this) {
      Branch.rat => "し",
      Branch.ox => "ちゅう",
      Branch.tiger => "いん",
      Branch.rabbit => "ぼう",
      Branch.dragon => "しん",
      Branch.snake => "し",
      Branch.horse => "ご",
      Branch.goat => "び",
      Branch.monkey => "しん",
      Branch.rooster => "ゆう",
      Branch.dog => "じゅつ",
      Branch.pig => "がい",
    };
  }

  String get baseNameOnRomany {
    return switch (this) {
      Branch.rat => "zǐ",
      Branch.ox => "chǒu",
      Branch.tiger => "yín",
      Branch.rabbit => "mǎo",
      Branch.dragon => "chén",
      Branch.snake => "sì",
      Branch.horse => "wǔ",
      Branch.goat => "wèi",
      Branch.monkey => "shēn",
      Branch.rooster => "yǒu",
      Branch.dog => "xū",
      Branch.pig => "hài",
    };
  }

  String get baseName {
    return switch (this) {
      Branch.rat => "子",
      Branch.ox => "丑",
      Branch.tiger => "寅",
      Branch.rabbit => "卯",
      Branch.dragon => "辰",
      Branch.snake => "巳",
      Branch.horse => "午",
      Branch.goat => "未",
      Branch.monkey => "申",
      Branch.rooster => "酉",
      Branch.dog => "戌",
      Branch.pig => "亥",
    };
  }
}