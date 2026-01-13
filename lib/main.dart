// File: lib/main.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sabail/src/app.dart';

/// Простая модель для прогресса инициализации
class Progress {
  final int percent;
  final String message;
  const Progress(this.percent, this.message);
}

void main() {
  runZonedGuarded(() async {
    // 1) Откладываем первый кадр до конца инициализации
    final binding = WidgetsFlutterBinding
        .ensureInitialized()..deferFirstFrame();

    // 2) Создаём notifier для передачи прогресса в UI
    final initializationProgress = ValueNotifier<Progress>(
      const Progress(0, 'Начало инициализации'),
    );

    // 3) Запускаем приложение
    runApp(_ProgressApp(initializationProgress));

    // 4) После первого build разрешаем показ первого кадра
    SchedulerBinding.instance.addPostFrameCallback((_) {
      binding.allowFirstFrame();
    });

    // 5) Последовательная инициализация шаг за шагом
    final steps = <String, Future<void> Function()>{
      'Инициализация базы данных': _migrateDatabase,
      'Инициализация Firebase': _initFirebase,
      'Загрузка настроек': _loadSettings,
    };

    int stepIndex = 0;
    final totalSteps = steps.length;
    for (final entry in steps.entries) {
      stepIndex++;
      final percent = ((stepIndex / totalSteps) * 100).round();
      initializationProgress.value =
          Progress(percent, entry.key);
      await entry.value();
    }

    // Финальный процент и небольшая задержка
    initializationProgress.value = const Progress(100, 'Готово');
    await Future.delayed(const Duration(milliseconds: 500));
  }, (error, stack) {
    // В случае серьёзной ошибки можно перекинуть на экран критической ошибки
    runApp(_ErrorApp(error: error.toString()));
  });
}

// Корневой виджет, слушает прогресс и переключается на App()
class _ProgressApp extends StatelessWidget {
  final ValueNotifier<Progress> notifier;
  const _ProgressApp(this.notifier);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Progress>(
      valueListenable: notifier,
      builder: (context, progress, _) {
        return MaterialApp(
          title: 'Saba’il',
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

/// Экран Splash с индикатором прогресса
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
                  "Saba’il",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Ваш путеводитель среди тьмы",
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

/// Экран ошибки, если что-то пошло не так
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
              'Не удалось инициализировать приложение:\n$error',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Замените эти методы на реальную логику инициализации:
Future<void> _migrateDatabase() async {
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> _initFirebase() async {
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> _loadSettings() async {
  await Future.delayed(const Duration(milliseconds: 500));
}
