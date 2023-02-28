import 'dart:async';

import 'package:behapp/Game/wackygame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Door extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<WackyGame> {
  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }
}
