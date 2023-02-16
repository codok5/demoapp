import 'dart:async';

import 'package:behapp/Game/model/direction.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/wackygame.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';

class Player extends SpriteAnimationComponent with HasGameRef<WackyGame> {
  late SpriteAnimationComponent runAnimation;
  late SpriteAnimationComponent runforwardAnimation;
  late SpriteAnimationComponent runbackAnimation;
  late SpriteAnimationComponent runrightAnimation;
  late SpriteAnimationComponent runleftAnimation;
  late SpriteAnimationComponent standingAnimation;
  late SpriteSheet spriteSheet;
  bool changed = false;
  Direction direction = Direction.idle;
  Character character = Character.baby;
  Player() : super(size: Vector2(100, 150), priority: 3);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    spriteSheet = SpriteSheet(
        image: await gameRef.images.load('${character.name}.png'),
        srcSize: Vector2(32, 32));

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    print('업로드');
    await add(
      FlameBlocListener<PlayerBloc, PlayerState>(
          listenWhen: (previousState, newState) =>
              newState.gear != previousState.gear,
          onNewState: _onNewGearState),
    );

    await add(FlameBlocListener<PlayerBloc, PlayerState>(
        listenWhen: (previousState, newState) =>
            newState.character != previousState.character,
        onNewState: _onNewCharacterState));
  }

  void _onNewGearState(PlayerState state) {
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

  void _onNewCharacterState(PlayerState state) async {
    spriteSheet = SpriteSheet(
        image: await gameRef.images.load('${state.character.name}.png'),
        srcSize: Vector2(32, 32));
    changed = true;
  }

  @override
  void update(double dt) {
    move();
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

  void move() {
    if (getdirection(gameRef.joystick.delta) == Vector2(1, 0)) {
      if (direction != Direction.right) {
        animation = spriteSheet.createAnimation(row: 2, stepTime: 0.2, to: 4);
      }
      direction = Direction.right;
      position.add(Vector2(5, 0));
    } else if (getdirection(gameRef.joystick.delta) == Vector2(-1, 0)) {
      if (direction != Direction.left) {
        animation = spriteSheet.createAnimation(row: 3, stepTime: 0.2, to: 4);
      }
      direction = Direction.left;
      position.add(Vector2(-5, 0));
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, 1)) {
      if (direction != Direction.front) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 4);
      }
      direction = Direction.front;
      position.add(Vector2(0, 5));
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, -1)) {
      if (direction != Direction.back) {
        animation = spriteSheet.createAnimation(row: 1, stepTime: 0.2, to: 4);
      }
      direction = Direction.back;
      position.add(Vector2(0, -5));
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, 0)) {
      if (direction != Direction.idle) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);
      }
      if (changed == true) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);
        changed = false;
      }
      direction = Direction.idle;
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
        position = Vector2(50, 25);
        break;
      case Slot.righthand:
        anchor = Anchor.bottomCenter;
        size = Vector2(20, 50);
        position = Vector2(30, 100);
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
