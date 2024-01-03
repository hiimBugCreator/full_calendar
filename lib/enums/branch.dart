/*
 * Product by Louis Vu.
 *
 * This class provide the branch - which is also called (地支) or (十二支).
 * These are twelve words referring to the 12 animals of the Eastern zodiac
 * used to indicate direction, four seasons, day, month, year
 * and hour in the past (equal two hours in modern times).
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

///This class provide the branch - which is also called (地支) or (十二支).
///These are twelve words referring to the 12 animals of the Eastern zodiac
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
  ///Get name of this branch in Vietnamese.
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

  ///Get name of this branch in Korean by Latin letters.
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

  ///Get name of this branch in Korean.
  String get koreanNameOnHangul {
    return switch (this) {
      Branch.rat => "자",
      Branch.ox => "축",
      Branch.tiger => "인",
      Branch.rabbit => "묘",
      Branch.dragon => "진",
      Branch.snake => "사",
      Branch.horse => "오",
      Branch.goat => "미",
      Branch.monkey => "신",
      Branch.rooster => "유",
      Branch.dog => "술",
      Branch.pig => "해",
    };
  }

  ///Get name of this branch in Japanese(Kunyomi) by Latin letters.
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

  ///Get name of this branch in Japanese(Kunyomi).
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

  ///Get name of this branch in Japanese(Onyomi) by Latin letters.
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

  ///Get name of this branch in Japanese(Onyomi).
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

  ///Get name of this branch in Chinese by Latin letters.
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

  ///Get name of this branch in Chinese by Latin letters.
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

  ///Get [[startedHour, endedHour]] of this branch.
  List<int> get hourRange {
    return switch (this) {
      Branch.rat => [23, 1],
      Branch.ox => [1, 3],
      Branch.tiger => [3, 5],
      Branch.rabbit => [5, 7],
      Branch.dragon => [7, 9],
      Branch.snake => [9, 11],
      Branch.horse => [11, 13],
      Branch.goat => [13, 15],
      Branch.monkey => [15, 17],
      Branch.rooster => [17, 19],
      Branch.dog => [19, 21],
      Branch.pig => [21, 23],
    };
  }
}
