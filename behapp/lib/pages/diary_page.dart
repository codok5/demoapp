import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:behapp/hivecustomobject/emotion_diary.dart';
import 'package:behapp/pages/diary_write_page.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';

import '../utils/formatter.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});
  static const routeName = '/diary';
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class Writeargument {
  final String date;
  final String? doc1;
  final String? doc2;
  final String? doc3;
  final Emotion? emotion;
  Writeargument({
    required this.date,
    required this.doc1,
    required this.doc2,
    required this.doc3,
    required this.emotion,
  });
}

class _DiaryPageState extends State<DiaryPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String date =
        format.format(ModalRoute.of(context)?.settings.arguments as DateTime);
    final diarydata = context.watch<EmotionDiaryState>().diarydata;
    final String? doc1 = diarydata[date]?.docfirst;
    final String? doc2 = diarydata[date]?.docsecond;
    final String? doc3 = diarydata[date]?.docthird;
    final Emotion? emoji = diarydata[date]?.emotion;

    final String emotion = diarydata[date]?.emotion == Emotion.happy
        ? 'happy'
        : diarydata[date]?.emotion == Emotion.good
            ? 'good'
            : diarydata[date]?.emotion == Emotion.sad
                ? 'sad'
                : diarydata[date]?.emotion == Emotion.tired
                    ? 'tired'
                    : diarydata[date]?.emotion == Emotion.angry
                        ? 'angry'
                        : '';

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
              Navigator.pushNamed(context, DiaryWritePage.routeName,
                  arguments: Writeargument(
                      date: date,
                      doc1: doc1,
                      doc2: doc2,
                      doc3: doc3,
                      emotion: emoji));
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: emotion != ''
                            ? Image.asset('assets/images/$emotion.png')
                            : Text(''),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    doc1 ?? '새로운 일기를 써보세요',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    doc2 ?? '',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    doc3 ?? '',
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
