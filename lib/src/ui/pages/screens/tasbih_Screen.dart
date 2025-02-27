import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with SingleTickerProviderStateMixin {
  int counter = 0;
  late Database db;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_animationController);
  }

  Future<void> _initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'tasbih_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE counter(id INTEGER PRIMARY KEY, value INTEGER)',
        );
      },
      version: 1,
    );

    final result = await db.query('counter', where: 'id = ?', whereArgs: [1]);

    if (result.isNotEmpty) {
      setState(() {
        counter = result.first['value'] as int;
      });
    } else {
      await db.insert('counter', {'id': 1, 'value': 0});
    }
  }

  Future<void> _updateCounter(int value) async {
    await db.update('counter', {'value': value}, where: 'id = ?', whereArgs: [1]);
  }

  void _incrementCounter() {
    setState(() {
      counter++;
    });
    _updateCounter(counter);

    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.reset();    // Гарантирует старт с 0
    _animationController.forward();
  }

  void _resetCounter() {
    setState(() {
      counter = 0;
    });
    _updateCounter(0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Тасбих'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FlutterIslamicIcons.solidTasbih2,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Text(
                '$counter',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: _incrementCounter,
              icon: const Icon(FlutterIslamicIcons.tasbih, color: Colors.white),
              label: const Text(
                'Считать',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh, color: Colors.red),
              label: const Text(
                'Сбросить',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
