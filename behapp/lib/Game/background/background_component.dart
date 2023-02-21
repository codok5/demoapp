import 'dart:async';

import 'package:behapp/Game/wackygame.dart';
import 'package:flame/components.dart';

class BackGround extends SpriteComponent with HasGameRef<WackyGame> {
  BackGround() : super(priority: 1, size: Vector2(2400, 2400));
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    await super.onLoad();
    position = gameRef.size / 2;
    sprite = await gameRef.loadSprite(
      'map1.png',
    );
  }
}

