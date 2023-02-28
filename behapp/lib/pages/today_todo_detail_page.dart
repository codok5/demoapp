import 'dart:async';

import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TodayTodoWidget extends StatefulWidget {
  final int goaltime;
  final int donetime;
  final String id_todo;
  final int index;
  final TodoType todoType;
  const TodayTodoWidget({
    Key? key,
    required this.goaltime,
    required this.donetime,
    required this.id_todo,
    required this.index,
    required this.todoType,
  }) : super(key: key);
  @override
  State<TodayTodoWidget> createState() => _TodayTodoWidgetState();
}

class _TodayTodoWidgetState extends State<TodayTodoWidget>
    with WidgetsBindingObserver {
  late int runtime;
  late Timer timer;
  bool isrun = false;
  @override
  void initState() {
    runtime = widget.donetime;
    timer = Timer(Duration(), () {});
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        pausetimer();
        break;
      default:
        break;
    }
  }

  void addTime(Timer timer) {
    setState(() {
      runtime = runtime + 1;
    });
  }

  void starttimer() {
    timer = Timer.periodic(Duration(seconds: 1), addTime);
    setState(() {
      isrun = true;
    });
  }

  void pausetimer() {
    timer.cancel();
    setState(() {
      isrun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.todoType == TodoType.timer
        ? Container(
            height: 300.h,
            width: 300.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                shape: BoxShape.rectangle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${inttominute(runtime)}',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      '${inttominute(widget.goaltime)}',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => isrun ? pausetimer() : starttimer(),
                  child: Icon(
                    isrun ? Icons.pause_circle : Icons.run_circle,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      context
                          .read<DateProgressProvider>()
                          .changetodaydonetime(widget.id_todo, runtime);
                    });
                  },
                  child: Text(
                    '시간 저장',
                  ),
                ),
                context.watch<TodoState>().tododata[widget.id_todo]!.goaltime *
                            60 <=
                        runtime
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            context
                                .read<DateProgressProvider>()
                                .togglecompleted(
                                    formatdatetoint(
                                        formatint.format(DateTime.now())),
                                    widget.id_todo);
                            context
                                .read<DateProgressProvider>()
                                .changetodaydonetime(widget.id_todo, runtime);
                            Navigator.pop(context, true);
                          });
                        },
                        child: Text('완료'),
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          )
        : Container(
            height: 200.h,
            width: 150.w,
            child: Center(
                child: ElevatedButton(
              onPressed: () {
                setState(() {
                  context.read<DateProgressProvider>().togglecompleted(
                      formatdatetoint(formatint.format(DateTime.now())),
                      widget.id_todo);
                  Navigator.pop(context, true);
                });
              },
              child: Text('완료'),
            )),
          );
  }
}
