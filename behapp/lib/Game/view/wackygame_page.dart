import 'package:behapp/Game/background/bloc/background_bloc.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';

import 'package:behapp/Game/player/bloc/player_bloc.dart';

import 'package:behapp/Game/view/wackygame_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WackyGamePage extends StatelessWidget {
  const WackyGamePage({super.key});
  
  static Route<void> route() {
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
          ],
          child: WackyGamePage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WackyGameView();
  }
}
