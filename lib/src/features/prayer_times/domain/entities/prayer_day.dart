class PrayerDay {
  final DateTime date;
  final int fajrMinutes;
  final int dhuhrMinutes;
  final int asrMinutes;
  final int maghribMinutes;
  final int ishaMinutes;

  const PrayerDay({
    required this.date,
    required this.fajrMinutes,
    required this.dhuhrMinutes,
    required this.asrMinutes,
    required this.maghribMinutes,
    required this.ishaMinutes,
  });

  int getMinuteFor(String key) {
    switch (key) {
      case 'fajr':
        return fajrMinutes;
      case 'dhuhr':
        return dhuhrMinutes;
      case 'asr':
        return asrMinutes;
      case 'maghrib':
        return maghribMinutes;
      case 'isha':
        return ishaMinutes;
      default:
        return 0;
    }
  }
}
