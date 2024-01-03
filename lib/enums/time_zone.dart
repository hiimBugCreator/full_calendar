///This class provide the timezone
///Use it quick [timezone] for quickly use as param on a few methods.
enum TimeZone {
  vietnamese,
  chinese,
  japanese,
  korean,
  indonesiaUTC7,
  indonesiaUTC8,
  indonesiaUTC9,
  malaysia,
  singapore,
  philippines,
  cambodia,
  laos,
  thailand,
  myanmar,
}

extension TimeZoneExtension on TimeZone {
  int get timezone {
    if (this == TimeZone.vietnamese ||
        this == TimeZone.indonesiaUTC7 ||
        this == TimeZone.cambodia ||
        this == TimeZone.laos ||
        this == TimeZone.myanmar ||
        this == TimeZone.thailand) {
      return 7;
    } else if (this == TimeZone.chinese ||
        this == TimeZone.singapore ||
        this == TimeZone.philippines ||
        this == TimeZone.malaysia ||
        this == TimeZone.indonesiaUTC8) {
      return 8;
    } else {
      return 9;
    }
  }
}
