import 'dart:async';

import 'package:behapp/components/player.dart';
import 'package:behapp/components/world.dart';
import 'package:behapp/utils/map_loader.dart';
import 'package:flame/game.dart';
import 'dart:ui';
import 'package:behapp/components/world_collidable.dart';


class GameWorld extends FlameGame with HasCollisionDetection{
  final Player _player1 = Player();
  final World _world = World();

  void onJoypadDirectionChanged(Direction direction) {
    _player1.direction = direction;
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    await add(_world);
    add(_player1);
    addWorldCollision();
    _player1.position = _world.size / 2;
    camera.followComponent(_player1,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

 

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });
}
