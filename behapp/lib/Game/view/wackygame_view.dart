import 'package:behapp/Game/background/bloc/background_bloc.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/inventory/view/inventory_view.dart';

import 'package:behapp/Game/player/bloc/player_bloc.dart';

import 'package:behapp/Game/wackygame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WackyGameView extends StatelessWidget {
  const WackyGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 35.h,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30.w,
              ),
              onPressed: () {
                Navigator.pop(context);
                
              },
            ),
          ),
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
                height: 150.h,
                width: double.infinity,
                child: InventoryView(),
              )
            ],
          )),
    );
  }
}
