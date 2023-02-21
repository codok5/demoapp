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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, WackyGamePage.route());
                },
                child: Text('입장')),
            ElevatedButton(
                onPressed: () async {
                  await Repository.AddItem(Item.sword1);
                },
                child: Text('sword1')),
            ElevatedButton(
                onPressed: () async {
                  await Repository.AddItem(Item.sword2);
                },
                child: Text('sword2')),
            ElevatedButton(
                onPressed: () async {
                  await Repository.AddItem(Item.hat);
                },
                child: Text('hat')),
            ElevatedButton(
                onPressed: () {
                  Repository.AddCharacter(Character.baby);
                },
                child: Text('add baby to charcaterlist')),
            ElevatedButton(
                onPressed: () {
                  Repository.AddCharacter(Character.boy);
                },
                child: Text('add boy to characterlist')),
            ElevatedButton(
                onPressed: () {
                  Repository.AddCharacter(Character.rabbit);
                },
                child: Text('add rabbit to characterlist')),
            ElevatedButton(
                onPressed: () {
                  print(gamesettingdb.get('characterlist'));
                },
                child: Text('a')),
          ],
        ),
      ),
    );
  }
}
