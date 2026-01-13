// File: lib/main.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sabail/src/app.dart';
import 'package:sabail/src/core/di/locator.dart';

/// Простая модель для прогресса инициализации
class Progress {
  final int percent;
  final String message;
  const Progress(this.percent, this.message);
}

Future<void> main() async {
  runZonedGuarded(() async {
    final binding = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();

    final initializationProgress = ValueNotifier<Progress>(
      const Progress(0, 'Запуск Sabail...'),
    );

    runApp(_ProgressApp(initializationProgress));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      binding.allowFirstFrame();
    });

    final steps = <String, Future<void> Function()>{
      'Migration DB': _migrateDatabase,
      'DI setup': _initDependencies,
      'Firebase init': _initFirebase,
      'Load settings': _loadSettings,
    };

    int stepIndex = 0;
    final totalSteps = steps.length;
    for (final entry in steps.entries) {
      stepIndex++;
      final percent = ((stepIndex / totalSteps) * 100).round();
      initializationProgress.value = Progress(percent, entry.key);
      await entry.value();
    }

    initializationProgress.value = const Progress(100, 'Готово');
    await Future.delayed(const Duration(milliseconds: 500));
  }, (error, stack) {
    runApp(_ErrorApp(error: error.toString()));
  });
}

class _ProgressApp extends StatelessWidget {
  final ValueNotifier<Progress> notifier;
  const _ProgressApp(this.notifier);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Progress>(
      valueListenable: notifier,
      builder: (context, progress, _) {
        return MaterialApp(
          title: 'Sabail',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: progress.percent < 100
              ? _SplashProgress(progress: progress)
              : const App(),
        );
      },
    );
  }
}

class _SplashProgress extends StatelessWidget {
  final Progress progress;
  const _SplashProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2FC07F),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.brightness_7, size: 72, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  "Sabail",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Все инструменты в одном месте",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  value: progress.percent / 100,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  progress.message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorApp extends StatelessWidget {
  final String error;
  const _ErrorApp({required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ошибка',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Что-то пошло не так при запуске:\n$error',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _migrateDatabase() async {
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> _initDependencies() async {
  await setupLocator();
}

Future<void> _initFirebase() async {
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> _loadSettings() async {
  await Future.delayed(const Duration(milliseconds: 500));
}
