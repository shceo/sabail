import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'quran.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createTableLastRead);
        await db.execute(createTableSettings);  // <=== ВАЖНО!
      },
    );
  }

  static const String createTableLastRead = '''
  CREATE TABLE IF NOT EXISTS last_read (
    id INTEGER PRIMARY KEY,
    surah_number INTEGER,
    verse_number INTEGER
  )
  ''';

  static const String createTableSettings = '''
  CREATE TABLE IF NOT EXISTS settings (
    key TEXT PRIMARY KEY,
    value TEXT
  )
  ''';
}
  