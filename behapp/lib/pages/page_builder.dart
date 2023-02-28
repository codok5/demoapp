import 'package:behapp/pages/calendar_page.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/game_setting_page.dart';

import 'package:behapp/pages/goals_page.dart';
import 'package:behapp/pages/today_page.dart';
import 'package:flutter/material.dart';

class PageBuilder extends StatefulWidget {
  const PageBuilder({super.key});
  static const routeName = '/';
  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  int selectedIndex = 2;

  PageController pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pagechange(index);
      },
      children: [
        GameSettingPage(),
        CalendarPage(),
        TodayPage(),
        DiaryPage(),
        GoalsPage(),
      ],
    );
  }

  void pagechange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomtap(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
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
        onTap: bottomtap,
        currentIndex: selectedIndex,
      ),
    );
  }
}
