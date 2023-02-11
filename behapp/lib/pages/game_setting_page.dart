import 'package:behapp/pages/game_page.dart';
import 'package:behapp/providers/game_setting/game_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameSettingPage extends StatefulWidget {
  const GameSettingPage({super.key});

  @override
  State<GameSettingPage> createState() => _GameSettingPageState();
}

class _GameSettingPageState extends State<GameSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // final List<String> char_list = context
    //         .watch<GameSettingState>()
    //         .gamesettingdata['setting']
    //         ?.character_list ??
    //     [];
    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           Navigator.pushNamed(context, GamePage.routeName);
    //         },
    //         child: Text(
    //           '입장',
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {},
    //         child: Text('${char_list}'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           context.read<GameSettingProvider>().addcharacter('char1');
    //         },
    //         child: Text('char1'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           context.read<GameSettingProvider>().addcharacter('char2');
    //         },
    //         child: Text(
    //           'char2',
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
