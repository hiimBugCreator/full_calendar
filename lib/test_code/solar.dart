part of lunar_calendar_converter;

class Solar {
  int solarYear;
  int solarMonth;
  int solarDay;

  Solar({required this.solarYear, required this.solarMonth, required this.solarDay});

  DateTime get dateTime => DateTime(solarYear, solarMonth, solarDay);

  @override
  String toString() {
    String result = "";
    if (solarYear != null) {
      int absYear = solarYear.abs();
      String prefix = (solarYear < 0 ? "公元前" : "公元");
      result += "$prefix$absYear年";
    }
    if (solarMonth != null) {
      if (solarMonth < 1 || solarMonth > 12) {
        return "非法日期";
      }
      result += "$solarMonth月";

      if (solarDay != null) {
        if (solarDay < 1 || solarDay > 31) {
          return "非法日期";
        }
        result += "$solarDay日";
      }
    }
    return result.length < 1 ? "非法日期" : result;
  }
}