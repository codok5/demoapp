import 'dart:async';

import 'package:behapp/Game/background/background_component.dart';
import 'package:behapp/Game/background/bloc/background_bloc.dart';
import 'package:behapp/Game/door/door_sprite.dart';
import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/obstacles/obstacle.dart';
import 'package:behapp/Game/plant/bloc/plant_bloc.dart';
import 'package:behapp/Game/plant/plant_component.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/player/player_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

class WackyGame extends FlameGame
    with HasCollisionDetection, HasDraggables, HasTappables {
  WackyGame(
      {required this.playerBloc,
      required this.inventoryBloc,
      required this.backgroundBloc,
      required this.plantBloc});

  final PlayerBloc playerBloc;
  final InventoryBloc inventoryBloc;
  final BackgroundBloc backgroundBloc;
  final PlantBloc plantBloc;

  late JoystickComponent joystick;
  late final Player player;
  late final BackGround backGround;
  late final PlantComponent plantComponent;

  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    await super.onLoad();
    final knobPaint = BasicPalette.white.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    final map = await TiledComponent.load('world.tmx', Vector2(16, 16));
    final List<TiledObject> obstacles =
        map.tileMap.getLayer<ObjectGroup>('obstacles')!.objects;
    final List<TiledObject> plants =
        map.tileMap.getLayer<ObjectGroup>('plant')!.objects;
    await add(
      FlameMultiBlocProvider(providers: [
        FlameBlocProvider<PlayerBloc, PlayerState>.value(
          value: playerBloc,
        ),
        FlameBlocProvider<InventoryBloc, InventoryState>.value(
          value: inventoryBloc,
        ),
        FlameBlocProvider<BackgroundBloc, BackgroundState>.value(
          value: backgroundBloc,
        ),
      ], children: [
        backGround = BackGround(),
        player = Player()..position = Vector2(500, 500),
      ]),
    );
    for (final TiledObject plant in plants) {
      add(FlameBlocProvider<PlantBloc, PlantState>(
          create: () => PlantBloc(), children: [PlantComponent(plant)]));
    }

    final pickbutton = HudButtonComponent(
      margin: EdgeInsets.fromLTRB(700, 300, 50, 50),
      button: SpriteComponent(
        sprite: Sprite(
          await images.load('pick_rabbit.png'),
        ),
        size: Vector2(30, 30),
      ),
      buttonDown: CircleComponent(),
      onPressed: () {
        player.pick();
      },
    );

    for (final TiledObject obstacle in obstacles) {
      add(Obstacle(obstacle));
    }

    add(Door());

    add(joystick);
    add(pickbutton);
    camera.followVector2(player.position,
        worldBounds: Rect.fromLTRB(0, 0, 1440, 1440));
  }
}
