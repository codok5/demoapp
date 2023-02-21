import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class BackGround extends PositionComponent {
  BackGround() : super(size: Vector2(1440, 1440));
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    final world = await TiledComponent.load('world.tmx', Vector2(16, 16));
    add(world..size = Vector2(1440, 1440));
  }
}
