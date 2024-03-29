import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Obstacle extends PositionComponent {
  final TiledObject obstacle;
  Obstacle(this.obstacle);
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    position = Vector2(obstacle.x, obstacle.y);
    size = Vector2(obstacle.width, obstacle.height);
    if (obstacle.isPolygon == true) {
      List<Vector2> vertices = [];
      for (Point point in obstacle.polygon) {
        vertices.add(Vector2(point.x, point.y));
      }
      add(PolygonHitbox(vertices));
    } else {
      add(RectangleHitbox());
    }
  }
}
