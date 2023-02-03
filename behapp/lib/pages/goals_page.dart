import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/providers/goal/goal_provider.dart';
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

List goalselected = List.filled(100, false);

class _GoalsPageState extends State<GoalsPage> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool iscompleted = true;
  bool istime = false;
  late List<bool> _isselected;

  @override
  void initState() {
    _isselected = [iscompleted, istime];
    super.initState();
  }

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
    final progressdb = context.watch<GoalState>().goalprogressdata;
    final keylist_goal = goaldata.keys.toList();
    final goallist = goaldata.values.toList();
    final String date =
        format.format(ModalRoute.of(context)?.settings.arguments as DateTime);
    final String day =
        formatw.format(ModalRoute.of(context)?.settings.arguments as DateTime);

    void toggletap(value) {
      setState(() {
        if (value == 0) {
          iscompleted = true;
          istime = false;
        } else if (value == 1) {
          iscompleted = false;
          istime = true;
        }
        _isselected = [
          iscompleted,
          istime,
        ];
      });
    }

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
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, indext) {
                                                      return goallist[index]
                                                                  .todo_map
                                                                  .length ==
                                                              0
                                                          ? Text(
                                                              '새로운 할일을 등록해 보세요',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                            )
                                                          : Text(
                                                              '${indext + 1}. ${goallist[index].todo_map.values.toList()[indext].name}',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                            );
                                                    },
                                                    itemCount: goallist[index]
                                                                .todo_map
                                                                .length ==
                                                            0
                                                        ? 1
                                                        : goallist[index]
                                                            .todo_map
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
                                                          context
                                                              .read<
                                                                  GoalProvider>()
                                                              .deletegoal(
                                                                  goallist[
                                                                          index]
                                                                      .id);
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
                                              onPressed: () {
                                                context
                                                    .read<GoalProvider>()
                                                    .addprogress(
                                                        goallist[index].id);
                                                setState(() {});
                                              },
                                              child: Text('g')),
                                          ElevatedButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 15,
                                                              vertical: 25,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '목표를 이루기 위해 새로운 일들을 계획해 보세요',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Form(
                                                                  key: formkey,
                                                                  child:
                                                                      TextFormField(
                                                                    validator:
                                                                        (value) {
                                                                      if (textEditingController1
                                                                          .text
                                                                          .trim()
                                                                          .isEmpty) {
                                                                        return '글자를 입력하세요';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    controller:
                                                                        textEditingController1,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          '할일을 정해보세요',
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                ToggleButtons(
                                                                  children: [
                                                                    Text(
                                                                        '단순 완료'),
                                                                    Text(
                                                                        '시간 완료'),
                                                                  ],
                                                                  isSelected:
                                                                      _isselected,
                                                                  onPressed:
                                                                      toggletap,
                                                                ),
                                                                istime
                                                                    ? Row(
                                                                        children: [
                                                                          Text(
                                                                            '하루 목표시간을 설정하세요',
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                50,
                                                                            child:
                                                                                TextField(
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
                                                                                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '분',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : SizedBox(
                                                                        height:
                                                                            0,
                                                                      ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      (() {
                                                                    if (formkey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      context
                                                                          .read<
                                                                              GoalProvider>()
                                                                          .addtodo(
                                                                            goallist[index].id,
                                                                            textEditingController1.text,
                                                                            iscompleted
                                                                                ? TodoType.completed
                                                                                : TodoType.time,
                                                                            iscompleted
                                                                                ? 0
                                                                                : int.parse(textEditingController2.text),
                                                                          );
                                                                      setState(
                                                                          () {});
                                                                      Navigator.pop(
                                                                          context);
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
                                                      ),
                                                    );
                                                  });
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
}
