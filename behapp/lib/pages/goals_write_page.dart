import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/providers/goal/goal_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalsWritePage extends StatefulWidget {
  const GoalsWritePage({super.key});
  static const routeName = '/goalswrite';

  @override
  State<GoalsWritePage> createState() => _GoalsWritePageState();
}

class _GoalsWritePageState extends State<GoalsWritePage> {
  DateTime startday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime endday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  GoalType goalType = GoalType.education;
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final _startday = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 50)) ??
                            startday;
                        setState(() {
                          startday = _startday;
                        });
                      },
                      child: Text('시작 날짜'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final _endday = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(DateTime.now().year + 50),
                            ) ??
                            endday;
                        setState(() {
                          endday = _endday;
                        });
                      },
                      child: Text('완료 날짜'),
                    ),
                  ],
                ),
                Text('시작 날짜 : ${format.format(startday)}'),
                Text('완료 날짜 : ${format.format(endday)}'),
                Text('총 기간 : ${endday.difference(startday).inDays + 1}'),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.all(
                    5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.shade50,
                      border: Border.all(
                        width: 3,
                        color: Colors.black,
                      )),
                  child: Form(
                    key: _formkey1,
                    child: TextFormField(
                      validator: (value) {
                        if (textEditingController2.text.trim().isEmpty) {
                          return '글자를 입력하세요';
                        } else {
                          return null;
                        }
                      },
                      controller: textEditingController1,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelText: '목표를 설정하세요!',
                        floatingLabelStyle: TextStyle(color: Colors.blueGrey),
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        contentPadding: EdgeInsets.all(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(
                    5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.shade50,
                      border: Border.all(
                        width: 3,
                        color: Colors.black,
                      )),
                  child: Form(
                    key: _formkey2,
                    child: TextFormField(
                      controller: textEditingController2,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        labelText: '목표에 대한 각오와 다짐들을 기록해 보세요!',
                        floatingLabelStyle: TextStyle(color: Colors.blueGrey),
                        filled: true,
                        fillColor: Colors.blueGrey.shade100,
                        contentPadding: EdgeInsets.all(
                          10,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (() {
                    if (_formkey1.currentState!.validate()) {
                      context.read<GoalProvider>().makegoal(
                            textEditingController1.text,
                            textEditingController2.text,
                            startday,
                            endday,
                            goalType,
                          );

                      Navigator.pop(context);
                    }
                  }),
                  child: Text('목표생성'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
