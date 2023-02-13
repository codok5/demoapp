import 'package:behapp/Game/view/wackygame_page.dart';
import 'package:flutter/material.dart';

class GameSettingPage extends StatefulWidget {
  const GameSettingPage({super.key});

  @override
  State<GameSettingPage> createState() => _GameSettingPageState();
}

class _GameSettingPageState extends State<GameSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, WackyGamePage.route());
              },
              child: Text('입장'))
        ],
      ),
    );
  }
}
