import 'package:behapp/Game/repository/repository.dart';
import 'package:behapp/Game/view/wackygame_page.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
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
              child: Text('입장')),
          ElevatedButton(
              onPressed: () {
                Repository.AddItem(Item.sword1);
              },
              child: Text('sword1')),
          ElevatedButton(
              onPressed: () {
                Repository.AddItem(Item.sword2);
              },
              child: Text('sword2')),
          ElevatedButton(
              onPressed: () {
                Repository.AddItem(Item.hat);
              },
              child: Text('hat')),
          ElevatedButton(
              onPressed: () {
                Repository.AddCharacter(Character.ailen);
              },
              child: Text('add ailen to charcaterlist')),
          ElevatedButton(
              onPressed: () {
                Repository.AddCharacter(Character.man);
              },
              child: Text('add man to characterlist')),
          ElevatedButton(
              onPressed: () {
                print(gamesettingdb.get('characterlist'));
              },
              child: Text('a')),
        ],
      ),
    );
  }
}
