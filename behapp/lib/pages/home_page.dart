import 'package:behapp/pages/calendar_page.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/goals_page.dart';
import 'package:behapp/pages/today_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetlist = <Widget>[
    CalendarPage(),
    TodayPage(),
    DiaryPage(),
    GoalsPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetlist[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Today'),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined), label: 'Diary'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Goal'),
        ],
        onTap: onTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
