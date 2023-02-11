import 'package:behapp/pages/calendar_page.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/game_setting_page.dart';
import 'package:behapp/pages/goals_page.dart';
import 'package:behapp/pages/today_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  final List<Widget> _widgetlist = <Widget>[
    GameSettingPage(),
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
      body: _widgetlist[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad_outlined), label: 'Game'),
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
