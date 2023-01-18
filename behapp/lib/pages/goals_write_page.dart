import 'package:flutter/material.dart';

class GoalsWritePage extends StatefulWidget {
  const GoalsWritePage({super.key});
  static const routeName = '/goalswrite';

  @override
  State<GoalsWritePage> createState() => _GoalsWritePageState();
}

class _GoalsWritePageState extends State<GoalsWritePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final startday = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 5));
                },
                child: Text('시작 날짜'),
              ),
              ElevatedButton(
                onPressed: (() async {
                  final endday = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 5),
                  );
                }),
                child: Text('완료 날짜'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
