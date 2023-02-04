import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/providers/goal/goal_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  static const routeName = '/goals';
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

List goalselected = List.filled(goaldb.keys.length, false);
List<bool> isselected = [true, false];

class _GoalsPageState extends State<GoalsPage> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, GoalObject> goaldata =
        context.watch<GoalState>().goaldata;
    final Map<dynamic, Map<String, dynamic>> progressdb =
        context.watch<GoalState>().goalprogressdata;
    final keylist_goal = goaldata.keys.toList();
    final goallist = goaldata.values.toList();
    final Map<dynamic, TodoObject> tododata =
        context.watch<TodoState>().tododata;
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
        body: SingleChildScrollView(
          child: Column(
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 20,
                      thickness: 0,
                      color: Colors.transparent,
                    );
                  },
                  itemCount: goallist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          goallist[index].name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          iconSize: 100,
                          onPressed: () {
                            setState(() {
                              goalselected[index] = !goalselected[index];
                            });
                          },
                          icon: ImageIcon(progressdb[keylist_goal[index]]![
                                      'progressstatus'] ==
                                  GoalProgressStatus.start
                              ? AssetImage('assets/images/before.png')
                              : progressdb[keylist_goal[index]]![
                                          'progressstatus'] ==
                                      GoalProgressStatus.inprogress
                                  ? AssetImage('assets/images/inprogress.png')
                                  : AssetImage('assets/images/completed1.png')),
                        ),
                        goalselected[index]
                            ? Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 4)),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '!!   ${goallist[index].content}   !!',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return Divider(
                                                        height: 5,
                                                        color:
                                                            Colors.transparent,
                                                      );
                                                    },
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, indext) {
                                                      return goallist[index]
                                                                  .id_todo_list
                                                                  .length ==
                                                              0
                                                          ? Text(
                                                              '새로운 할일을 등록해 보세요',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                            )
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                return showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Dialog(
                                                                      child: Container(
                                                                          height: MediaQuery.of(context).size.height / 3,
                                                                          padding: EdgeInsets.all(20),
                                                                          decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              30,
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            children: [
                                                                              Text(
                                                                                '${tododata[goallist[index].id_todo_list[indext]]!.name}',
                                                                              ),
                                                                              Text(
                                                                                tododata[goallist[index].id_todo_list[indext]]!.todoType == TodoType.nontimer ? '단순 완료형' : '타이머형',
                                                                              ),
                                                                              Text(tododata[goallist[index].id_todo_list[indext]]!.todoType == TodoType.timer ? '하루 목표 시간 : ${tododata[goallist[index].id_todo_list[indext]]!.goaltime}' : ''),
                                                                            ],
                                                                          )),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        border:
                                                                            Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.blueGrey,
                                                                        )),
                                                                child: Text(
                                                                  ' ${tododata[goallist[index].id_todo_list[indext]]!.name}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                    },
                                                    itemCount: goallist[index]
                                                                .id_todo_list
                                                                .length ==
                                                            0
                                                        ? 1
                                                        : goallist[index]
                                                            .id_todo_list
                                                            .length,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          '아니오',
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: (() {
                                                          for (var id_todo
                                                              in goallist[index]
                                                                  .id_todo_list) {
                                                            context
                                                                .read<
                                                                    TodoProvider>()
                                                                .deletetodo(
                                                                    id_todo);
                                                          }
                                                          context
                                                              .read<
                                                                  GoalProvider>()
                                                              .deletegoal(
                                                                  goallist[
                                                                          index]
                                                                      .id_goal);

                                                          setState(() {
                                                            goalselected[
                                                                index] = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
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
                                            onPressed: () async {
                                              return TodoWrite(
                                                  context, goallist, index);
                                            },
                                            child: Text('매일의 할일 생성'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> TodoWrite(
      BuildContext context, List<GoalObject> goallist, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '목표를 이루기 위해 새로운 일들을 계획해 보세요',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: formkey,
                          child: TextFormField(
                            validator: (value) {
                              if (textEditingController1.text.trim().isEmpty) {
                                return '글자를 입력하세요';
                              } else {
                                return null;
                              }
                            },
                            controller: textEditingController1,
                            decoration: InputDecoration(
                              labelText: '할일을 정해보세요',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ToggleButtons(
                            children: [Text('단순 완료'), Text('시간 완료')],
                            isSelected: isselected,
                            onPressed: (index) {
                              setState(() {
                                if (index == 0) {
                                  isselected = [true, false];
                                } else if (index == 1) {
                                  isselected = [false, true];
                                }
                              });
                            }),
                        isselected[1]
                            ? Row(
                                children: [
                                  Text(
                                    '하루 목표시간을 설정하세요',
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                      controller: textEditingController2,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '분',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: 0,
                              ),
                        ElevatedButton(
                          onPressed: (() {
                            if (formkey.currentState!.validate()) {
                              context.read<TodoProvider>().maketodo(
                                    id_goal: goallist[index].id_goal,
                                    name: textEditingController1.text,
                                    todoType: isselected[0]
                                        ? TodoType.nontimer
                                        : TodoType.timer,
                                    goaltime: isselected[0]
                                        ? 0
                                        : int.parse(
                                            textEditingController2.text),
                                  );
                              setState(() {
                                textEditingController1.text = '';
                                textEditingController2.text = '';
                              });
                              isselected = [true, true];
                              Navigator.pop(context);
                            }
                          }),
                          child: Text(
                            '생성',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
