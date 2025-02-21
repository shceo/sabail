import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'favorites.db'),
      version: 2, // Увеличенная версия
      onCreate: (db, version) async {
        // Создаем таблицу favorites
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT NOT NULL
          )
        ''');
        // Создаем таблицу basket
        await db.execute('''
          CREATE TABLE basket (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId TEXT,
            name TEXT,
            price REAL,
            size TEXT,
            color TEXT,
            imagePath TEXT,
            counter INTEGER DEFAULT 1
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          
          await db.execute('''
            CREATE TABLE basket (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              productId TEXT,
              name TEXT,
              price REAL,
              size TEXT,
              color TEXT,
              imagePath TEXT,
              counter INTEGER DEFAULT 1
            )
          ''');
        }
      },
    );
  }

  Future<void> addFavorite(String imagePath) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'imagePath': imagePath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String imagePath) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'imagePath = ?',
      whereArgs: [imagePath],
    );
  }

  Future<List<String>> getFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');
    return List.generate(maps.length, (i) => maps[i]['imagePath'] as String);
  }

  Future<void> addToBasket({
    required String productId,
    required String name,
    required double price,
    required String size,
    required String color,
    required String imagePath,
  }) async {
    final db = await database;
    await db.insert(
      'basket',
      {
        'productId': productId,
        'name': name,
        'price': price,
        'size': size,
        'color': color,
        'imagePath': imagePath,
        'counter': 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getBasketItems() async {
    final db = await database;
    final maps = await db.query('basket');
    return maps;
  }

  Future<void> updateBasketItemCounter(int id, int counter) async {
    final db = await database;
    await db.update(
      'basket',
      {'counter': counter},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeBasketItem(int id) async {
    final db = await database;
    await db.delete(
      'basket',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
