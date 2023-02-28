import 'dart:async';

import 'package:behapp/Game/model/plant.dart';
import 'package:behapp/Game/plant/bloc/plant_bloc.dart';
import 'package:behapp/Game/wackygame.dart';
import 'package:flame/components.dart';

import 'package:flame/sprite.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';

class PlantComponent extends SpriteComponent
    with
        Tappable,
        HasGameRef<WackyGame>,
        FlameBlocReader<PlantBloc, PlantState> {
  final TiledObject plants;
  late final SpriteSheet spriteSheet;

  PlantComponent(this.plants);

  @override
  Future<void> onLoad() async {
    List<Plant> plantlist = gameRef.plantBloc.state.plantlist;
    spriteSheet = SpriteSheet(
      image: await gameRef.images.load('Farming_Plants.png'),
      srcSize: Vector2(16, 16),
    );
    sprite = spriteSheet.getSprite(
      plantlist[0].plantStatus.order,
      plantlist[0].plantKind.order,
    );
    position = Vector2(plants.x, plants.y);
    size = Vector2(plants.width, plants.height);
    return super.onLoad();
  }

  @override
  bool onTapUp(TapUpInfo info) {
    try {
      print('tap!');
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
