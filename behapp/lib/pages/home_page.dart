import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/goals_page.dart';
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
  int selectedDateint = formatdatetoint(formatint.format(DateTime.now()));
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.align_vertical_bottom_outlined),
              label: 'Goal',
            ),
          ],
          onTap: (value) {
            if (value == 1) {
              Navigator.pushNamed(context, DiaryPage.routeName,
                  arguments: _selectedDay);
            } else if (value == 2) {
              Navigator.pushNamed(
                context,
                GoalsPage.routeName,
                arguments: _selectedDay,
              );
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
                    selectedDateint =
                        formatdatetoint(formatint.format(selectedDay));
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                locale: 'ko_KR',
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.red),
                ),
                focusedDay: _focusedDay,
                firstDay: DateTime(DateTime.now().year - 20),
                lastDay: DateTime(DateTime.now().year + 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DiaryWidget(
              selectedDay: selectedDateint,
            ),
            GoalWidget(
              selectedDay: selectedDateint,
            ),
          ],
        ),
      );
    });
  }
}

class GoalWidget extends StatelessWidget {
  final int selectedDay;
  const GoalWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String goal =
        context.watch<EmotionDiaryState>().diarydata[selectedDay]?.docfirst ??
            '새로운 목표를 써 보세요';
    return Column(
      children: [
        Text('오늘의 목표'),
        Container(
          margin: const EdgeInsets.all(5),
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blueGrey,
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  goal,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DiaryWidget extends StatelessWidget {
  final int selectedDay;

  const DiaryWidget({
    Key? key,
    required this.selectedDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String doc1 =
        context.watch<EmotionDiaryState>().diarydata[selectedDay]?.docfirst ??
            '새로운 일기를 써 보세요';
    String doc2 =
        context.watch<EmotionDiaryState>().diarydata[selectedDay]?.docsecond ??
            '';
    String doc3 =
        context.watch<EmotionDiaryState>().diarydata[selectedDay]?.docthird ??
            '';
    return Builder(builder: (BuildContext context) {
      return Column(
        children: [
          Text('오늘의 일기'),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    doc1,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    doc2,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    doc3,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
