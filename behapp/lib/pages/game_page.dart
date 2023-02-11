import 'package:behapp/flame/gameworld.dart';
import 'package:behapp/utils/joypad.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});
  static const routeName = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final game = GameWorld();
  @override
  Widget build(BuildContext context) {
    
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
