import 'package:behapp/Game/background/bloc/background_bloc.dart';
import 'package:behapp/Game/characterlist/bloc/characterlist_bloc.dart';

import 'package:behapp/Game/inventory/bloc/inventory_bloc.dart';
import 'package:behapp/Game/plant/bloc/plant_bloc.dart';
import 'package:behapp/Game/player/bloc/player_bloc.dart';

import 'package:behapp/Game/view/wackygame_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WackyGamePage extends StatefulWidget {
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
            BlocProvider<CharacterlistBloc>(
              create: (context) => CharacterlistBloc(),
            ),
            BlocProvider<PlantBloc>(
              create: (context) => PlantBloc(),
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
  State<WackyGamePage> createState() => _WackyGamePageState();
}

class _WackyGamePageState extends State<WackyGamePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return WackyGameView();
    });
  }
}
