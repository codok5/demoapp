import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/providers/goal/goal_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  static const routeName = '/goals';
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

List goalselected = List.filled(1000, false);

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
    final Map<dynamic, GoalObject> goaldata =
        context.watch<GoalState>().goaldata;
    final goallist = goaldata.values.toList();
    final String date =
        format.format(ModalRoute.of(context)?.settings.arguments as DateTime);
    final String day =
        formatw.format(ModalRoute.of(context)?.settings.arguments as DateTime);
    return Material(
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          child: Text(
            '목표 생성',
          ),
          onPressed: () {
            Navigator.pushNamed(context, GoalsWritePage.routeName);
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '$date $day',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 10,
                  );
                },
                itemCount: goallist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              goalselected[index] = !goalselected[index];
                            });
                          },
                          child: Text(
                            goallist[index].name,
                          ),
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 10),
                            backgroundColor: Colors.amber.shade200,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                        ),
                      ),
                      goalselected[index]
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '나의 각오 :   ${goallist[index].content}',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '시작 날짜 : ${format.format(goallist[index].startday)}',
                                    ),
                                    Text(
                                      '완료 날짜 : ${format.format(goallist[index].endday)}',
                                    ),
                                    Text(
                                      '진행률 : ',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: (() async {
                                        return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('삭제하시겠습니까?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    '아니오',
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: (() {
                                                    context
                                                        .read<GoalProvider>()
                                                        .deletegoal(
                                                            goallist[index].id);
                                                    setState(() {
                                                      goalselected[index] =
                                                          false;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                                  child: Text(
                                                    '네',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }),
                                      child: Text(
                                        '삭제',
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: (() {}),
                                        child: Text('매일의 할일 생성'))
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      LinearPercentIndicator(
                        backgroundColor: Colors.black26,
                        progressColor: Colors.green,
                        width: MediaQuery.of(context).size.width,
                        lineHeight: 10,
                        percent: 0.8,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
