import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/providers/goal/goal_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  static const routeName = '/goals';
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

List<bool> goalselected = List.filled(100, false);
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
    final Map<dynamic, Map<String, dynamic>> progressdata =
        context.watch<GoalState>().goalprogressdata;
    final keylist_goal = goaldata.keys.toList();
    final goallist = goaldata.values.toList();
    final Map<dynamic, TodoObject> tododata =
        context.watch<TodoState>().tododata;

    return Material(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.3),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              goalselected[index] = !goalselected[index];
                            });
                          },
                          child: Image(
                            image: progressdata[keylist_goal[index]]![
                                        'progressstatus'] ==
                                    GoalProgressStatus.start
                                ? AssetImage('assets/images/before.png')
                                : progressdata[keylist_goal[index]]![
                                            'progressstatus'] ==
                                        GoalProgressStatus.inprogress
                                    ? AssetImage('assets/images/inprogress.png')
                                    : AssetImage('assets/images/ailen.png'),
                            width: 100,
                            height: 100,
                          ),
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
                                      Text(''),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return Divider(
                                              height: 5,
                                              color: Colors.transparent,
                                            );
                                          },
                                          shrinkWrap: true,
                                          itemBuilder: (context, indext) {
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
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            child:
                                                                MakeTodoWidget(
                                                              tododata:
                                                                  tododata,
                                                              goallist:
                                                                  goallist,
                                                              index: index,
                                                              indext: indext,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            width: 1,
                                                            color:
                                                                Colors.blueGrey,
                                                          )),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            ' ${tododata[goallist[index].id_todo_list[indext]]?.name}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
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
                                      LinearPercentIndicator(
                                        percent: progressdata[goallist[index]
                                                            .id_goal]![
                                                        'presentprogress'] /
                                                    progressdata[goallist[index]
                                                            .id_goal]![
                                                        'totalprogress'] >
                                                1
                                            ? 1
                                            : progressdata[goallist[index]
                                                        .id_goal]![
                                                    'presentprogress'] /
                                                context
                                                    .watch<GoalState>()
                                                    .goalprogressdata[goallist[
                                                        index]
                                                    .id_goal]!['totalprogress'],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: (() async {
                                              return ShowRemoveDialog(
                                                  context, goallist, index);
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
                                          goallist[index].completed == true
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<GoalProvider>()
                                                        .addprogress(
                                                            goallist[index]
                                                                .id_goal);
                                                  },
                                                  child: Text('완료'),
                                                )
                                              : SizedBox(width: 0)
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

  Future<void> ShowRemoveDialog(
      BuildContext context, List<GoalObject> goallist, int index) {
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
                List<dynamic> deletekey = [...goallist[index].id_todo_list];
                for (var id_todo in deletekey) {
                  context.read<TodoProvider>().deletetodo(id_todo);
                }
                context
                    .read<GoalProvider>()
                    .deletegoal(goallist[index].id_goal);

                setState(() {
                  goalselected[index] = false;
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
  }

  Future<void> TodoWrite(
      BuildContext context, List<GoalObject> goallist, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
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
                      horizontal: 15.w,
                      vertical: 25.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '목표를 이루기 위해 새로운 일들을 계획해 보세요',
                          style: TextStyle(
                            fontSize: 22.sp,
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
                          height: 30.h,
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
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.sp,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 3.w,
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
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                width: 0.w,
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
                              isselected = [true, false];
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

class MakeTodoWidget extends StatelessWidget {
  const MakeTodoWidget({
    super.key,
    required this.tododata,
    required this.goallist,
    required this.index,
    required this.indext,
  });

  final Map<dynamic, TodoObject> tododata;
  final List<GoalObject> goallist;
  final int index;
  final int indext;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Column(
        children: [
          Text(
            '${tododata[goallist[index].id_todo_list[indext]]!.name}',
          ),
          Text(
            tododata[goallist[index].id_todo_list[indext]]!.todoType ==
                    TodoType.nontimer
                ? '단순 완료형'
                : '타이머형',
          ),
          Text(tododata[goallist[index].id_todo_list[indext]]!.todoType ==
                  TodoType.timer
              ? '하루 목표 시간 : ${tododata[goallist[index].id_todo_list[indext]]!.goaltime}'
              : ''),
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
                              .read<TodoProvider>()
                              .deletetodo(goallist[index].id_todo_list[indext]);
                          Navigator.pop(context);
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
        ],
      ),
    );
  }
}
