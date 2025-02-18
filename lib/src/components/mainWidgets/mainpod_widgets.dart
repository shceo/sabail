import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:sabail/src/ui/pages/sadaqa_project.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPodWidgets extends StatelessWidget {
  const MainPodWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['Викторина', 'صدقة', 'Календарь'];
    List<IconData> icons = [
      FlutterIslamicIcons.solidLantern,
      FlutterIslamicIcons.solidZakat,
      FlutterIslamicIcons.calendar
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page(index)),
            );
          },
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icons[index],
                  size: 28,
                  color: SabailColors.darkpurple,
                ),
                Text(
                  texts[index],
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int index;
  Page(this.index);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('99 имен Аллаха'),
        ),
        body: const Center(
          child: Text('Здесь будут отображаться 99 имен Аллаха'),
        ),
      );
    } else if (index == 1) {
      return const SadaqaProj();
    } else {
      return const IslamicCalendarPage();
    }
  }
}

class IslamicCalendarPage extends StatefulWidget {
  const IslamicCalendarPage({Key? key}) : super(key: key);

  @override
  _IslamicCalendarPageState createState() => _IslamicCalendarPageState();
}

class _IslamicCalendarPageState extends State<IslamicCalendarPage> {
  late final Future<Map<DateTime, List<String>>> _holidaysFuture;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _holidays = {};

  @override
  void initState() {
    super.initState();
    _holidaysFuture = _fetchHolidays();
  }

  Future<Map<DateTime, List<String>>> _fetchHolidays() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      DateTime.utc(2025, 3, 10): ['Начало Рамадана'],
      DateTime.utc(2025, 4, 10): ['Конец Рамадана'],
      DateTime.utc(2025, 5, 1): ['Ид аль-Фитр'],
      DateTime.utc(2025, 7, 1): ['Ид аль-Адха'],
    };
  }

  List<String> _getEventsForDay(DateTime day) {
    return _holidays[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Календарь')),
      body: FutureBuilder<Map<DateTime, List<String>>>(
        future: _holidaysFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.white,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки праздников'));
          } else {
            _holidays = snapshot.data!;
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getEventsForDay,
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: SabailColors.darkpurple,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: const TextStyle(color: Colors.redAccent),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: SabailColors.darkpurple,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _selectedDay != null
                      ? _buildEventList(_selectedDay!)
                      : const Center(child: Text('Выберите дату')),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildEventList(DateTime day) {
    List<String> events = _getEventsForDay(day);
    if (events.isEmpty) {
      return const Center(child: Text('Нет событий на этот день'));
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: ListTile(
            leading: Icon(FlutterIslamicIcons.mosque, color: SabailColors.darkpurple),
            title: Text(
              events[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
