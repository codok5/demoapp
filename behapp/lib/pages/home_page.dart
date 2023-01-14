import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedDate = format.format(DateTime.now());
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime.now();

    return Builder(builder: (BuildContext context) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Diary',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Action',
            ),
          ],
          onTap: (value) {
            if (value == 1) {
              Navigator.pushNamed(context, DiaryPage.routeName,
                  arguments: DateTime.now());
            }
          },
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              color: Colors.blueGrey.withOpacity(0.2),
              child: TableCalendar(
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = format.format(selectedDay);
                      _selectedDay = selectedDay;
                    });
                  },
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: CalendarFormat.month,
                  locale: 'ko_KR',
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                      weekendTextStyle: TextStyle(color: Colors.red)),
                  focusedDay: focusedDay,
                  firstDay: DateTime(
                      focusedDay.year - 10, focusedDay.month, focusedDay.day),
                  lastDay: DateTime(
                      focusedDay.year + 10, focusedDay.month, focusedDay.day)),
            ),
            const SizedBox(
              height: 20,
            ),
            DiaryWidget(
              selectedDay: selectedDate,
            ),
            GoalWidget(
              selectedDay: selectedDate,
            ),
            
          ],
        ),
      );
    });
  }
}

class GoalWidget extends StatelessWidget {
  final String selectedDay;
  const GoalWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String goal = context.watch<EmotionDiaryState>().diarydata[selectedDay]?[0]?? '새로운 목표를 설정하세요';
    return Container(
      margin: const EdgeInsets.all(5),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1),
          border: Border.all(color: Colors.blueGrey)),
      child: Text(goal),
    );
  }
}

class DiaryWidget extends StatelessWidget {
  final String selectedDay;

  const DiaryWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String diary = context.watch<EmotionDiaryState>().diarydata[selectedDay]?[0]?? '새로운 일기를 써보세요';
    return Builder(builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(5),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            border: Border.all(color: Colors.blueGrey)),
        child: Text(diary),
      );
    });
  }
}
