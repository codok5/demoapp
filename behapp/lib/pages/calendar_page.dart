import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey.withOpacity(0.2),
        child: Column(
          children: [
            TableCalendar(
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
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
            SizedBox(
              height: 100,
            ),
            DiaryWidget(
              selectedDay: _selectedDay,
            ),
            GoalWidget(
              selectedDay: _selectedDay,
            ),
          ],
        ),
      ),
    );
  }
}

class GoalWidget extends StatelessWidget {
  final DateTime selectedDay;
  const GoalWidget({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? todaytodolist = context
        .watch<DateProgressState>()
        .dateprogressdata[formatdatetoint(formatint.format(selectedDay))];
    final Map<dynamic, TodoObject> tododata =
        context.watch<TodoState>().tododata;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Text('오늘의 할일'),
          Container(
            margin: const EdgeInsets.all(5),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blueGrey,
                )),
            child: todaytodolist != null && todaytodolist.length != 0
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Text(
                                '${tododata[todaytodolist[index].id_todo]?.name}',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 2,
                                color: Colors.transparent,
                              );
                            },
                            itemCount: todaytodolist.length),
                      ),
                    ],
                  )
                : Text(
                    '새로운 할일을 입력하세요',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
          ),
        ],
      );
    });
  }
}

class DiaryWidget extends StatelessWidget {
  final DateTime selectedDay;
  const DiaryWidget({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int selectedDate = formatdatetoint(formatint.format(selectedDay));
    String doc1 =
        context.watch<EmotionDiaryState>().diarydata[selectedDate]?.docfirst ??
            '새로운 일기를 써 보세요';
    String doc2 =
        context.watch<EmotionDiaryState>().diarydata[selectedDate]?.docsecond ??
            '';
    String doc3 =
        context.watch<EmotionDiaryState>().diarydata[selectedDate]?.docthird ??
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
