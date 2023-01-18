import 'package:behapp/hivecustomobject/emotion_diary.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DiaryWritePage extends StatefulWidget {
  const DiaryWritePage({super.key});
  static const routeName = '/diarywrite';

  @override
  State<DiaryWritePage> createState() => _DiaryWritePageState();
}

class _DiaryWritePageState extends State<DiaryWritePage> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  Emotion selectedEmotion = Emotion.initial;
  final FocusNode focusNode = FocusNode();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arg = ModalRoute.of(context)?.settings.arguments as Writeargument;
      _textEditingController1.text = arg.doc1 ?? '';
      _textEditingController2.text = arg.doc2 ?? '';
      _textEditingController3.text = arg.doc3 ?? '';
      selectedEmotion = arg.emotion ?? Emotion.initial;
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Writeargument;
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                arg.date,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  controller: _scrollController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            textform(
                                textEditingController1:
                                    _textEditingController1),
                            textform2(
                                scrollController: _scrollController,
                                textEditingController2:
                                    _textEditingController2),
                            textform3(
                                focusNode: focusNode,
                                scrollController: _scrollController,
                                textEditingController3:
                                    _textEditingController3),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedEmotion = Emotion.happy;
                                          });
                                        },
                                        icon: Image.asset(
                                            'assets/images/happy.png')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedEmotion == Emotion.happy
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedEmotion = Emotion.good;
                                          });
                                        },
                                        icon: Image.asset(
                                            'assets/images/good.png')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedEmotion == Emotion.good
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedEmotion = Emotion.tired;
                                          });
                                          print(selectedEmotion);
                                        },
                                        icon: Image.asset(
                                            'assets/images/tired.png')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedEmotion == Emotion.tired
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedEmotion = Emotion.sad;
                                          });
                                        },
                                        icon: Image.asset(
                                            'assets/images/sad.png')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedEmotion == Emotion.sad
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedEmotion = Emotion.angry;
                                          });
                                        },
                                        icon: Image.asset(
                                            'assets/images/angry.png')),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        width: 3,
                                        color: selectedEmotion == Emotion.angry
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.black),
                                  backgroundColor: Colors.blueGrey.shade300),
                              onPressed: () {
                                if (_textEditingController1.text.trim().length != 0 &&
                                    _textEditingController2.text
                                            .trim()
                                            .length !=
                                        0 &&
                                    _textEditingController3.text
                                            .trim()
                                            .length !=
                                        0) {
                                  context
                                      .read<EmotionDiaryProvider>()
                                      .writeDiary(
                                          arg.date,
                                          _textEditingController1.text,
                                          _textEditingController2.text,
                                          _textEditingController3.text,
                                          selectedEmotion);
                                  Navigator.pop(context);
                                } else {
                                  return;
                                }
                              },
                              child: Text('생성'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        )),
      ),
    );
  }
}

class textform3 extends StatelessWidget {
  const textform3({
    Key? key,
    required this.focusNode,
    required ScrollController scrollController,
    required TextEditingController textEditingController3,
  })  : _scrollController = scrollController,
        _textEditingController3 = textEditingController3,
        super(key: key);

  final FocusNode focusNode;
  final ScrollController _scrollController;
  final TextEditingController _textEditingController3;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        onTap: () {
          _scrollController.animateTo(
            250,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        },
        onSaved: (newValue) {
          print(_textEditingController3.text);
        },
        controller: _textEditingController3,
        style: TextStyle(
          fontSize: 30,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          labelText: '오늘의 슬픔은 무엇인가요?',
          floatingLabelStyle: TextStyle(color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.blueGrey.shade100,
          contentPadding: EdgeInsets.all(
            10,
          ),
        ),
      ),
    );
  }
}

class textform2 extends StatelessWidget {
  const textform2({
    Key? key,
    required ScrollController scrollController,
    required TextEditingController textEditingController2,
  })  : _textEditingController2 = textEditingController2,
        _scrollController = scrollController,
        super(key: key);

  final TextEditingController _textEditingController2;
  final ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        onTap: () {
          _scrollController.animateTo(
            170,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        },
        onSaved: (newValue) {
          print(_textEditingController2.text);
        },
        controller: _textEditingController2,
        style: TextStyle(
          fontSize: 30,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          labelText: '오늘의 행복은 무엇인가요?',
          floatingLabelStyle: TextStyle(color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.blueGrey.shade100,
          contentPadding: EdgeInsets.all(
            10,
          ),
        ),
      ),
    );
  }
}

class textform extends StatelessWidget {
  const textform({
    Key? key,
    required TextEditingController textEditingController1,
  })  : _textEditingController1 = textEditingController1,
        super(key: key);

  final TextEditingController _textEditingController1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        onTap: () {},
        onSaved: (newValue) {
          print(_textEditingController1.text);
        },
        controller: _textEditingController1,
        style: TextStyle(
          fontSize: 30,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          labelText: '오늘 하루는 무엇을 했나요?',
          floatingLabelStyle: TextStyle(color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.blueGrey.shade100,
          contentPadding: EdgeInsets.all(
            10,
          ),
        ),
      ),
    );
  }
}
