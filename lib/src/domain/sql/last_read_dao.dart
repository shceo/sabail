import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class LastReadDao {
  Future<void> saveLastRead(int surahNumber, int verseNumber) async {
    final db = await DatabaseHelper().database;
    const table = 'last_read';

    await db.insert(
      table,
      {
        'id': 1,  // Чтобы всегда была одна запись
        'surah_number': surahNumber,
        'verse_number': verseNumber,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getLastRead() async {
    final db = await DatabaseHelper().database;
    const table = 'last_read';

    final result = await db.query(table, where: 'id = ?', whereArgs: [1]);

    if (result.isNotEmpty) {
      final row = result.first;

      return {
        'surah_number': row['surah_number'],
        'verse_number': row['verse_number'],
      };
    }
    return null;
  }
}
