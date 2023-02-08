import 'dart:async';

import 'package:behapp/providers/date_progress/date_progress_provider.dart';
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

class _TodayTodoWidgetState extends State<TodayTodoWidget> {
  late int runtime;
  late Timer timer;
  bool isrun = false;
  @override
  void initState() {
    runtime = widget.donetime;
    super.initState();
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
      child: Column(children: [
        Row(
          children: [
            Text(
              '${runtime}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text('/'),
            Text(
              '${widget.goaltime}',
              style: TextStyle(
                fontSize: 20,
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
