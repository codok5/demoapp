import 'dart:async';

import 'package:behapp/Game/background/background_component.dart';
import 'package:behapp/Game/background/bloc/background_bloc.dart';
import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/player/player_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

class WackyGame extends FlameGame with HasCollisionDetection, HasDraggables {
  WackyGame({
    required this.playerBloc,
    required this.inventoryBloc,
    required this.backgroundBloc,
  });

  final PlayerBloc playerBloc;
  final InventoryBloc inventoryBloc;
  final BackgroundBloc backgroundBloc;
  late JoystickComponent joystick;
  late final Player player;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(size.x, size.y));
    await add(
      FlameMultiBlocProvider(providers: [
        FlameBlocProvider<PlayerBloc, PlayerState>.value(value: playerBloc),
        FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc),
        FlameBlocProvider<BackgroundBloc, BackgroundState>.value(
            value: backgroundBloc),
      ], children: [
        BackGround(),
        player = Player()..y = 300,
      ]),
    );
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
    camera.followComponent(player);
  }
}
