import 'package:behapp/Game/background/bloc/background_bloc.dart';
import 'package:behapp/Game/characterlist/bloc/characterlist_bloc.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:flame/flame.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';

import 'package:behapp/Game/view/wackygame_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WackyGamePage extends StatelessWidget {
  const WackyGamePage({super.key});

  static Route<void> route() {
    Flame.device.setLandscape();
    Flame.device.fullScreen();
    return MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<InventoryBloc>(
              create: (context) => InventoryBloc(),
            ),
            BlocProvider<PlayerBloc>(
              create: (context) => PlayerBloc(),
            ),
            BlocProvider<BackgroundBloc>(
              create: (context) => BackgroundBloc(),
            ),
            BlocProvider<CharacterlistBloc>(
              create: (context) => CharacterlistBloc(),
            ),
          ],
          child: Builder(builder: (context) {
            return WackyGamePage();
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return WackyGameView();
    });
  }
}
