import 'package:flutter/material.dart';
import 'package:full_calender/enums/branch.dart';
import 'package:full_calender/enums/language_name.dart';
import 'package:full_calender/enums/time_zone.dart';
import 'package:full_calender/full_calender.dart';
import 'package:full_calender/full_calender_extension.dart';

// Use this package for better log-line
// import 'package:logger_beauty/logger_beauty.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final lunarDate = FullCalender.now(TimeZone.vietnamese.timezone).lunarDate;
    final solarDate =
        FullCalenderExtension.convertLunarDateToSolarDate(lunarDate);
    final lstLuckyHour = lunarDate.listLuckyHours;
    final lstHour = lunarDate.listStemBranchOfHour;
    final next7date = lunarDate.getDateNext(7);

    //Use logger_beauty for better log screen and test this bellow code:

    //logDebug(FullCalenderExtension.checkIsDateBefore(
    //         fromDate: DateTime(2000, 12, 12),
    //         toDate: DateTime(2001, 10, 11))); -> false

    //logDebug(FullCalenderExtension.rangeOf2Dates(
    //         fromDate: DateTime(2000, 12, 12),
    //         toDate: DateTime(2000, 12, 18))); -> 6

    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Calendar Example'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Solar Date: $solarDate',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Julian Day: ${FullCalenderExtension.convertLunarDateToJulianDay(lunarDate)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Lunar Date: $lunarDate',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Lunar Date after 7 day is: $next7date',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Year: ${lunarDate.stemBranchOfYear.name(LanguageName.vietNam)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Month: ${lunarDate.stemBranchOfMonth.name(LanguageName.vietNam)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Day: ${lunarDate.stemBranchOfDay.name(LanguageName.vietNam)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'First hour: ${lunarDate.listStemBranchOfHour[0].name(LanguageName.vietNam)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              var str = lstHour[index].name(LanguageName.vietNam);
              str +=
                  '(${lstHour[index].branch.hourRange[0]}-${lstHour[index].branch.hourRange[1]})';
              str += ': ${lstLuckyHour[index] ? 'Lucky' : 'Unlucky'}';
              return ListTile(title: Text(str));
            },
            itemCount: lstHour.length,
          )
        ]),
      ),
    );
  }
}
