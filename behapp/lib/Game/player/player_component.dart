import 'dart:async';

import 'package:behapp/hivecustomobject/item.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/wackygame.dart';

class Player extends PositionComponent with HasGameRef<WackyGame> {
  late final PositionComponent runAnimation;
  late final PositionComponent idleAnimation;

  Player() : super(size: Vector2(60, 100), priority: 3);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    await add(
        FlameBlocListener<PlayerBloc, PlayerState>(onNewState: _onNewState));
    final idle = await gameRef.loadSprite('ailen.png');
    idleAnimation =
        SpriteComponent(sprite: idle, size: size, position: Vector2(50, 50));
    add(idleAnimation);
  }

  void _onNewState(PlayerState state) {
    for (final child in children.whereType<PlayerGear>()) {
      child.removeFromParent();
    }

    for (final entry in state.gear.entries) {
      final item = entry.value;
      if (item != null) {
        add(PlayerGear(slot: item.slots, item: item));
      } else {}
    }
  }

  @override
  void update(double dt) {
    position.add(getdirection(gameRef.joystick.delta) * 100 * dt);
    super.update(dt);
  }

  Vector2 getdirection(Vector2 delta) {
    if (delta == Vector2(0, 0)) {
      return Vector2(0, 0);
    } else if (delta[0].abs() > delta[1].abs()) {
      if (delta[0] > 0) {
        return Vector2(1, 0);
      } else {
        return Vector2(-1, 0);
      }
    } else {
      if (delta[1] > 0) {
        return Vector2(0, 1);
      } else {
        return Vector2(0, -1);
      }
    }
  }
}

class PlayerGear extends SpriteComponent with HasGameRef<WackyGame> {
  final Slot slot;
  final Item item;
  PlayerGear({
    required this.slot,
    required this.item,
  }) : super(priority: 4);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('${item.name}.png');

    switch (slot) {
      case Slot.head:
        anchor = Anchor.bottomCenter;
        size = Vector2(60, 40);
        position = Vector2(80, 60);
        break;
      case Slot.righthand:
        anchor = Anchor.bottomCenter;
        size = Vector2(20, 50);
        position = Vector2(65, 130);
        break;
      case Slot.lefthand:
        anchor = Anchor.bottomCenter;
        size = Vector2(20, 50);
        position = Vector2(0, 0);
        break;
      case Slot.top:
        anchor = Anchor.bottomCenter;
        size = Vector2(80, 30);
        position = Vector2(0, 0);
        break;
      case Slot.pants:
        anchor = Anchor.bottomCenter;
        size = Vector2(80, 30);
        position = Vector2(0, 0);
        break;
      case Slot.shoe:
        anchor = Anchor.bottomCenter;
        size = Vector2(80, 30);
        position = Vector2(0, 0);
        break;
    }
  }
}
