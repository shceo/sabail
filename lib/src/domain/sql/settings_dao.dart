import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class SettingsDao {
  Future<void> saveTheme(bool isDark) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'settings',
      {'key': 'is_dark_theme', 'value': isDark ? '1' : '0'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> getTheme() async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: ['is_dark_theme'],
    );
    if (result.isNotEmpty) {
      return result.first['value'] == '1';
    }
    return false;
  }

  Future<int?> getSelectedTranslation() async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: ['selected_translation'],
    );
    if (result.isNotEmpty) {
      return int.tryParse(result.first['value'] as String);
    }
    return null;
  }

  Future<void> saveSelectedTranslation(int translationId) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'settings',
      {'key': 'selected_translation', 'value': translationId.toString()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
