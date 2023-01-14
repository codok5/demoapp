import 'package:behapp/pages/diary_write_page.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/formatter.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});
  static const routeName = '/diary';
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date =
        format.format(ModalRoute.of(context)?.settings.arguments as DateTime);
    final diarydata = context.watch<EmotionDiaryState>().diarydata;

    return Builder(builder: (BuildContext context) {
      return Container(
        
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/paper.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: const Color.fromARGB(255, 225, 236, 186),
            ),
            onPressed: () {
              Navigator.pushNamed(context, DiaryWritePage.routeName);
            },
            child: const Text(
              '새로운 일기 작성하기',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    diarydata[date]?[0] ?? '새로운 일기를 써보세요',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
      );
    });
  }
}
