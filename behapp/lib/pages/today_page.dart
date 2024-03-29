import 'package:behapp/hiveCustomModel/todo.dart';
import 'package:behapp/pages/diary_page.dart';

import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:behapp/widget/coin_get_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'today_todo_detail_page.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
        body: SingleChildScrollView(
          child: Column(
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
              ElevatedButton(
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return CoinGetDialog(reward: 10);
                      },
                    );
                  },
                  child: Text('획득')),
            ],
          ),
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
    double todopercent =
        (todaytodolist?.where((element) => element.completed == true).length ??
                0.0) /
            (todaytodolist?.length ?? 1);
    return Column(
      children: [
        Text('오늘의 할일'),
        Container(
          margin: const EdgeInsets.all(5),
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blueGrey,
              )),
          child: Row(
            children: [
              Center(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 98,
                  lineWidth: 35,
                  progressColor: Colors.amber,
                  percent: todopercent,
                  center: Text(
                    '${(todopercent * 100).round()}%',
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              todaytodolist != null && todaytodolist.length != 0
                  ? Expanded(
                      child: ListView.separated(
                          padding: EdgeInsets.only(top: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                bool? completed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: TodayTodoWidget(
                                        todoType: tododata[
                                                todaytodolist[index].id_todo]!
                                            .todoType,
                                        goaltime: tododata[todaytodolist[index]
                                                    .id_todo]!
                                                .goaltime *
                                            60,
                                        donetime:
                                            todaytodolist[index].done_time,
                                        id_todo: todaytodolist[index].id_todo,
                                        index: index,
                                      ),
                                    );
                                  },
                                );
                                if (completed == true) {
                                  setState(() {});
                                }
                              },
                              child: Consumer<DateProgressProvider>(
                                builder: (context, value, child) {
                                  return Container(
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
                                  );
                                },
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
                    )
                  : Text(
                      '새로운 할일을 입력하세요',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
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
