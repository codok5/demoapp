import 'dart:async';

import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayTodoWidget extends StatefulWidget {
  final int goaltime;
  final int donetime;
  final String id_todo;
  const TodayTodoWidget({
    Key? key,
    required this.goaltime,
    required this.donetime,
    required this.id_todo,
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
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${inttominute(runtime)}',
              style: TextStyle(
                fontSize: 40,
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
            context
                .read<DateProgressProvider>()
                .changetodaydonetime(widget.id_todo, runtime);
          },
          child: Text(
            '시간 저장',
          ),
        ),
      ]),
    );
  }
}
