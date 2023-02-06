import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});
  static const routeName = '/';
  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60.w,
            ),
            SizedBox(
              height: 20.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DiaryPage.routeName,
                );
              },
              child: DiaryWidget(),
            ),
            GoalWidget(),
            ElevatedButton(onPressed: () {}, child: Text('a'))
          ],
        ),
      );
    });
  }
}

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic>? todaytodolist = context
        .watch<DateProgressState>()
        .dateprogressdata[formatdatetoint(formatint.format(DateTime.now()))];
    final Map<dynamic, TodoObject> tododata =
        context.watch<TodoState>().tododata;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Text('오늘의 할일'),
          Container(
            margin: const EdgeInsets.all(5),
            height: 200.w,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blueGrey,
                )),
            child: todaytodolist != null && todaytodolist.length != 0
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: 200.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${tododata[todaytodolist[index].id_todo]?.name}',
                                      ),
                                      tododata[todaytodolist[index].id_todo]!
                                                  .todoType ==
                                              TodoType.timer
                                          ? Text(
                                              'timer ${tododata[todaytodolist[index].id_todo]!.goaltime}')
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<DateProgressProvider>()
                                              .completetodo(
                                                  formatdatetoint(formatint
                                                      .format(DateTime.now())),
                                                  todaytodolist[index].id_todo);
                                          setState(() {});
                                        },
                                        child: Text(
                                          '완료',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 2,
                            color: todaytodolist[index].completed
                                ? Colors.red
                                : Colors.black,
                          )),
                          child: Text(
                            '${tododata[todaytodolist[index].id_todo]?.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 2,
                        color: Colors.transparent,
                      );
                    },
                    itemCount: todaytodolist.length)
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
  const DiaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDay = formatdatetoint(formatint.format(DateTime.now()));
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
