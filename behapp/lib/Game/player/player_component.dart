import 'dart:async';

import 'package:behapp/Game/model/direction.dart';
import 'package:behapp/Game/obstacles/obstacle.dart';
import 'package:behapp/Game/repository/repository.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';

import 'package:behapp/Game/model/Item.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/wackygame.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<WackyGame> {
  late SpriteSheet spriteSheet;

  late SpriteAnimation runforwardAnimation =
      spriteSheet.createAnimation(row: 4, stepTime: 0.2, to: 8);
  late SpriteAnimation runbackAnimation =
      spriteSheet.createAnimation(row: 5, stepTime: 0.2, to: 8);
  late SpriteAnimation runrightAnimation =
      spriteSheet.createAnimation(row: 6, stepTime: 0.2, to: 8);
  late SpriteAnimation runleftAnimation =
      spriteSheet.createAnimation(row: 7, stepTime: 0.2, to: 8);
  late SpriteAnimation idleforwardAnimation =
      spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 8);
  late SpriteAnimation idlebackAnimation =
      spriteSheet.createAnimation(row: 1, stepTime: 0.2, to: 8);
  late SpriteAnimation idlerightAnimation =
      spriteSheet.createAnimation(row: 3, stepTime: 0.2, to: 8);
  late SpriteAnimation idleleftAnimation =
      spriteSheet.createAnimation(row: 2, stepTime: 0.2, to: 8);
  late SpriteAnimation pickforwardAnimation =
      spriteSheet.createAnimation(row: 12, stepTime: 0.1, to: 8);
  late SpriteAnimation pickrightAnimation =
      spriteSheet.createAnimation(row: 15, stepTime: 0.1, to: 8);
  late SpriteAnimation pickleftAnimation =
      spriteSheet.createAnimation(row: 14, stepTime: 0.1, to: 8);
  late SpriteAnimation pickbackAnimation =
      spriteSheet.createAnimation(row: 13, stepTime: 0.1, to: 8);
  bool picked = false;
  bool canmoveRight = true;
  bool canmoveLeft = true;
  bool canmoveFront = true;
  bool canmoveBack = true;
  Direction collidedDirection = Direction.idle;
  Direction direction = Direction.idle;

  late final mapsize;

  Character character = Repository.GetLatestCharacter() ?? Character.baby;
  Player() : super(size: Vector2(96, 96), priority: 3);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    mapsize = gameRef.backGround.size;
    anchor = Anchor.center;

    spriteSheet = SpriteSheet(
        image: await gameRef.images.load('action_rabbit.png'),
        srcSize: Vector2(48, 48));

    animation = idleforwardAnimation;
    for (final entry in Repository.GetEquipedGear().entries) {
      final item = entry.value;
      if (item != null) {
        add(PlayerGear(slot: item.slots, item: item));
      } else {}
    }

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

    add(
      CircleHitbox(
        radius: 21,
        anchor: Anchor.center,
        position: Vector2(48, 48),
      ),
    );
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Obstacle) {
      List<Vector2> interl = [];

      for (Vector2 inter in intersectionPoints) {
        inter.sub(position);
        interl.add(inter);
      }

      if (interl.length == 2) {
        double x1 = (interl[0].x - interl[1].x).abs();
        double y1 = (interl[0].y - interl[1].y).abs();
        if (x1 < y1) {
          if (interl[0].x > 0) {
            canmoveRight = false;
            canmoveLeft = true;
          } else {
            canmoveLeft = false;
            canmoveRight = true;
          }
        } else {
          if (interl[0].y > 0) {
            canmoveFront = false;
            canmoveBack = true;
          } else {
            canmoveBack = false;
            canmoveFront = true;
          }
        }
      } else if (interl.length == 4) {
        double x1 = (interl[0].x - interl[1].x).abs();
        double x2 = (interl[2].x - interl[3].x).abs();
        double y1 = (interl[0].y - interl[1].y).abs();
        double y2 = (interl[2].y - interl[3].y).abs();

        if (x1 < y1) {
          if (interl[0].x > 0) {
            canmoveRight = false;
            canmoveLeft = true;
            if (x2 > y2) {
              if (interl[2].y > 0) {
                canmoveFront = false;
              } else {
                canmoveBack = false;
              }
            }
          } else {
            canmoveLeft = false;
            canmoveRight = true;
            if (x2 > y2) {
              if (interl[2].y > 0) {
                canmoveFront = false;
              } else {
                canmoveBack = false;
              }
            }
          }
        } else {
          if (interl[0].y > 0) {
            canmoveFront = false;
            if (x2 < y2) {
              if (interl[2].x > 0) {
                canmoveRight = false;
              } else {
                canmoveLeft = false;
              }
            }
          } else {
            canmoveBack = false;
            if (x2 < y2) {
              if (interl[2].x > 0) {
                canmoveRight = false;
              } else {
                canmoveLeft = false;
              }
            }
          }
        }
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    canmoveBack = true;
    canmoveFront = true;
    canmoveRight = true;
    canmoveLeft = true;
  }

  void _onNewCharacterState(PlayerState state) async {
    spriteSheet = SpriteSheet(
        image: await gameRef.images.load('${state.character.name}.png'),
        srcSize: Vector2(32, 32));
    updateAnimation(spriteSheet);
  }

  void updateAnimation(SpriteSheet spriteSheet) {
    runforwardAnimation =
        spriteSheet.createAnimation(row: 4, stepTime: 0.2, to: 8);
    runbackAnimation =
        spriteSheet.createAnimation(row: 5, stepTime: 0.2, to: 8);
    runrightAnimation =
        spriteSheet.createAnimation(row: 6, stepTime: 0.2, to: 8);
    runleftAnimation =
        spriteSheet.createAnimation(row: 7, stepTime: 0.2, to: 8);
    idleforwardAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 8);
    idlebackAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.2, to: 8);
    idlerightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: 0.2, to: 8);
    idleleftAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.2, to: 8);
  }

  @override
  void update(double dt) {
    move();
    action();
    super.update(dt);
  }

  void action() {
    if (picked == true) {
      if (animation == idleforwardAnimation) {
        animation = pickforwardAnimation;
        Future.delayed(Duration(milliseconds: 1500), () {
          picked = false;
          animation = idleforwardAnimation;
        });
      } else if (animation == idlerightAnimation) {
        animation = pickrightAnimation;
        Future.delayed(Duration(milliseconds: 1500), () {
          picked = false;
          animation = idlerightAnimation;
        });
      } else if (animation == idleleftAnimation) {
        animation = pickleftAnimation;
        Future.delayed(Duration(milliseconds: 1500), () {
          picked = false;
          animation = idleleftAnimation;
        });
      } else if (animation == idlebackAnimation) {
        animation = pickbackAnimation;
        Future.delayed(Duration(milliseconds: 1500), () {
          picked = false;
          animation = idlebackAnimation;
        });
      }
    } else {}
  }

  void pick() {
    picked = true;
  }

  Direction getdirection(JoystickComponent joystickComponent) {
    if (joystickComponent.relativeDelta[0] > 0 &&
        joystickComponent.relativeDelta[0].abs() >
            joystickComponent.relativeDelta[1].abs()) {
      return Direction.right;
    } else if (joystickComponent.relativeDelta[0] < 0 &&
        joystickComponent.relativeDelta[0].abs() >
            joystickComponent.relativeDelta[1].abs()) {
      return Direction.left;
    } else if (joystickComponent.relativeDelta[1] > 0) {
      return Direction.front;
    } else if (joystickComponent.relativeDelta[1] < 0) {
      return Direction.back;
    } else {
      return Direction.idle;
    }
  }

  void move() {
    Direction playerdirection = getdirection(gameRef.joystick);
    if (playerdirection == Direction.right && canmoveRight) {
      if (direction != Direction.right) {
        animation = runrightAnimation;
      }
      direction = Direction.right;
      position.add(Vector2(gameRef.joystick.relativeDelta[0] * 3, 0));
    } else if (playerdirection == Direction.left && canmoveLeft) {
      if (direction != Direction.left) {
        animation = runleftAnimation;
      }
      direction = Direction.left;
      position.add(Vector2(gameRef.joystick.relativeDelta[0] * 3, 0));
    } else if (playerdirection == Direction.front && canmoveFront) {
      if (direction != Direction.front) {
        animation = runforwardAnimation;
      }
      direction = Direction.front;
      position.add(Vector2(0, gameRef.joystick.relativeDelta[1] * 3));
    } else if (playerdirection == Direction.back && canmoveBack) {
      if (direction != Direction.back) {
        animation = runbackAnimation;
      }
      direction = Direction.back;
      position.add(Vector2(0, gameRef.joystick.relativeDelta[1] * 3));
    } else if (playerdirection == Direction.idle) {
      if (direction == Direction.back) {
        animation = idlebackAnimation;
      } else if (direction == Direction.right) {
        animation = idlerightAnimation;
      } else if (direction == Direction.left) {
        animation = idleleftAnimation;
      } else if (direction == Direction.front) {
        animation = idleforwardAnimation;
      }
      direction = Direction.idle;
    }
  }
}

class PlayerGear extends SpriteAnimationComponent with HasGameRef<WackyGame> {
  final Slot slot;
  final Item item;
  PlayerGear({
    required this.slot,
    required this.item,
  }) : super(priority: 4);

  late SpriteSheet spriteSheet;
  Direction direction = Direction.idle;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    spriteSheet = SpriteSheet(
        image: await gameRef.images.load('${item.name}_${slot.name}.png'),
        srcSize: Vector2(50, 50));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.3, to: 1);
    switch (slot) {
      case Slot.head:
        anchor = Anchor.bottomCenter;
        size = Vector2(25.w, 45.h);
        position = Vector2(15.w, 16.h);
        break;
      case Slot.righthand:
        anchor = Anchor.bottomCenter;
        size = Vector2(70.w, 90.h);
        position = Vector2(30.w, 100.h);
        break;
      case Slot.lefthand:
        anchor = Anchor.bottomCenter;
        size = Vector2(70, 70);
        position = Vector2(0, 0);
        break;
      case Slot.top:
        anchor = Anchor.bottomCenter;
        size = Vector2(50, 50);
        position = Vector2(0, 0);
        break;
      case Slot.pants:
        anchor = Anchor.bottomCenter;
        size = Vector2(50, 50);
        position = Vector2(0, 0);
        break;
      case Slot.shoe:
        anchor = Anchor.bottomCenter;
        size = Vector2(50, 50);
        position = Vector2(0, 0);
        break;
    }
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

  @override
  void update(double dt) {
    move();
    super.update(dt);
  }

  void move() {
    if (getdirection(gameRef.joystick.delta) == Vector2(1, 0)) {
      if (direction != Direction.right) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 2);
      }
      direction = Direction.right;
    } else if (getdirection(gameRef.joystick.delta) == Vector2(-1, 0)) {
      if (direction != Direction.left) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 2);
      }
      direction = Direction.left;
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, 1)) {
      if (direction != Direction.front) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 2);
      }
      direction = Direction.front;
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, -1)) {
      if (direction != Direction.back) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 2);
      }
      direction = Direction.back;
    } else if (getdirection(gameRef.joystick.delta) == Vector2(0, 0)) {
      if (direction != Direction.idle) {
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.3, to: 1);
      }

      direction = Direction.idle;
    }
  }
}
