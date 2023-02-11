import 'package:behapp/flame/gameworld.dart';
import 'package:behapp/providers/game_setting/game_setting_provider.dart';
import 'package:behapp/utils/joypad.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  static const routeName = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    final game =
        GameWorld(gameSettingProvider: context.read<GameSettingProvider>());
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Joypad(
                onDirectionChanged: game.onJoypadDirectionChanged,
              ),
            ),
          )
        ],
      ),
    );
  }
}
