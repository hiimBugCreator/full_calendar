class LunarDateTime {
  final int year;
  final int month;
  final int day;

  // final String nameOfDate;
  // final String nameOfMonth;
  // final String nameOfYear;
  final bool isLeap;

  LunarDateTime(
      {required this.year,
      required this.month,
      required this.day,
      this.isLeap = false});

  @override
  String toString() {
    return '$day/${isLeap ? 'leap ' : ''}$month/$year';
  }
}
