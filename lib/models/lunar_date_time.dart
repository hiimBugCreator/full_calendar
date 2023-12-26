import 'package:full_calender/full_calender.dart';
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
  final _gioHoangDao = [
    '110100101100',
    '001101001011',
    '110011010010',
    '101100110100',
    '001011001101',
    '010010110011'
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

  @override
  String toString() {
    return '$day/${isLeap ? 'leap ' : ''}$month/$year';
  }
}
