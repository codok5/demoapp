import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});
  static const routeName = '/goals';
  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 50,
            ),
            
          ],
        ),
      ),
    );
  }
}
