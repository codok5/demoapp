import 'package:behapp/utils/formatter.dart';
import 'package:flutter/material.dart';

class DiaryWritePage extends StatefulWidget {
  const DiaryWritePage({super.key});
  static const routeName = '/diarywrite';

  @override
  State<DiaryWritePage> createState() => _DiaryWritePageState();
}

class _DiaryWritePageState extends State<DiaryWritePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/paper.jpg'),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  format.format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              WriteWidget(),
            ],
          )),
        ),
      ),
    );
  }
}

class WriteWidget extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: TextField(
          controller: textEditingController,
          style: TextStyle(
            fontSize: 30,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey.shade100,
            contentPadding: EdgeInsets.all(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
