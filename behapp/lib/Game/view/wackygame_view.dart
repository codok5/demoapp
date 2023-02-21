import 'package:behapp/Game/background/bloc/background_bloc.dart';
import 'package:behapp/Game/characterlist/view/characterlist_view.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/inventory/view/inventory_view.dart';

import 'package:behapp/Game/player/bloc/player_bloc.dart';
import 'package:behapp/Game/repository/repository.dart';

import 'package:behapp/Game/wackygame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WackyGameView extends StatelessWidget {
  WackyGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 48.h,
            backgroundColor: Colors.black,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Repository.SaveSetting(
                        gear: context.read<PlayerBloc>().state.gear,
                        character: context.read<PlayerBloc>().state.character);
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              GameWidget(
                game: WackyGame(
                  playerBloc: context.read<PlayerBloc>(),
                  inventoryBloc: context.read<InventoryBloc>(),
                  backgroundBloc: context.read<BackgroundBloc>(),
                ),
              ),
              Positioned(
                top: 90.h,
                left: 10.w,
                child: SizedBox(
                  height: 30.h,
                  width: MediaQuery.of(context).size.width,
                  child: CharacterListView(),
                ),
              ),
              Positioned(
                top: 60.h,
                left: 10.w,
                child: SizedBox(
                  height: 30.h,
                  width: MediaQuery.of(context).size.width,
                  child: InventoryView(),
                ),
              ),
            ],
          )),
    );
  }
}
