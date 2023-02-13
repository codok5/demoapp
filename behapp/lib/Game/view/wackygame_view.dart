import 'package:behapp/Game/background/bloc/background_bloc.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/inventory/view/inventory_view.dart';

import 'package:behapp/Game/player/bloc/player_bloc.dart';

import 'package:behapp/Game/wackygame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WackyGameView extends StatelessWidget {
  const WackyGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: GameWidget(
            game: WackyGame(
              playerBloc: context.read<PlayerBloc>(),
              inventoryBloc: context.read<InventoryBloc>(),
              backgroundBloc: context.read<BackgroundBloc>(),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: InventoryView(),
        )
      ],
    ));
  }
}
