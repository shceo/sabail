import '../domain/entities/prayer_day.dart';

class PrayerTimesService {
  Future<PrayerDay> fetchFor(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Простая мок-логика: слегка сдвигаем время в зависимости от дня,
    // чтобы выглядело правдоподобно.
    final dayOfYear = int.parse(
      '${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
    );
    final shift = (dayOfYear % 12) - 6; // -6..+5 минут

    int base(int hour, int minute) => hour * 60 + minute + shift;

    return PrayerDay(
      date: DateTime(date.year, date.month, date.day),
      fajrMinutes: base(4, 45),
      dhuhrMinutes: base(12, 5),
      asrMinutes: base(15, 20),
      maghribMinutes: base(18, 5),
      ishaMinutes: base(19, 20),
    );
  }
}
