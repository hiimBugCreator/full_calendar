### 💰 Sponsor for my work:
- Momo:
[![Tài trợ qua MoMo](https://img.shields.io/badge/MoMo-Ủng_Hộ-af007b?style=for-the-badge&logo=mo-mo&logoColor=white)](https://me.momo.vn/sponsor2hiimbugcreator)

# Full Calendar Flutter Library

Welcome to the Full Calendar Library! This library provides a comprehensive set of tools for working
with lunar dates, stems, branches, and more, making it easy to integrate traditional calendar
features into your Flutter applications.

## Features

- **Lunar Date Conversion:** Easily convert between solar and lunar dates.
- **Number of Julian day Conversion:** Easily convert solar and lunar dates to number of Julian day.
- **Stems and Branches:** Retrieve stems and branches for years, months, days, and hours.
- **Multilingual Support:** Get names and representations in various languages.
- **Lucky Day and Hour Detection:** Find out if a day or hour is considered lucky based on lunar
  calendar principles.

## Getting Started

To use this library, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  full_calender: 
```

Then run:
```shell
$ flutter pub get
```

Import the library in your Dart code:
```dart
import 'package:full_calender/full_calender.dart';
```

## Usage

Lunar Date Conversion
```dart
// Convert lunar date to solar date
final lunarDate = LunarDateTime(year: 2023, month: 11, day: 10);
final solarDate = FullCalenderExtension.convertLunarDateToSolarDate(lunarDate);
print(solarDate); // Output: 2023-12-28
```

Stems and Branches
```dart
// Get stem and branch for a specific year
final stemBranchOfYear = StemBranch.year(2023);
print(stemBranchOfYear.name(LanguageName.vietNam)); // Output: Kỷ Hợi
```

Lucky Day and Hour Detection
```dart
// Check if a specific day is considered lucky
final luckyDay = FullCalender(date: DateTime(2023, 12, 28)).lunarDate.isLuckyDay;
print(luckyDay); // Output: true

// Get a list of lucky hours for a specific date
final luckyHours = FullCalender(date: DateTime(2023, 11, 20)).lunarDate.listLuckyHours;
print(luckyHours); // Output: [true, true,false,true,false,false,true,false,true,true,false,false]
```

Stems and Branches
```dart
// Get stem and branch for a specific year
final stemBranchOfYear = StemBranch.year(2023);
print(stemBranchOfYear.name(LanguageName.vietNam)); // Output: Kỷ Hợi
```

For more examples, check out the [example](https://github.com/hiimBugCreator/full_calendar/tree/main/example) directory.

Issues and Feedback
Please file issues or provide feedback on our [GitHub repository](https://github.com/hiimBugCreator/full_calendar/).