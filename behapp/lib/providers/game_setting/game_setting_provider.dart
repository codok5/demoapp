import 'package:equatable/equatable.dart';
import 'package:behapp/hivecustomobject/game_setting.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:hive/hive.dart';
part 'game_setting_state.dart';

class GameSettingProvider extends StateNotifier<GameSettingState>
    with LocatorMixin {
  GameSettingProvider() : super(GameSettingState.initial());

  void addcharacter(String char) {
    Map<String, GameSettingObject> newgamesettingdata = {
      ...state.gamesettingdata
    };
    List<String> newchar_list = [
      char,
      ...newgamesettingdata['setting']?.character_list ?? []
    ];
    newgamesettingdata['setting'] = GameSettingObject(
        character_list: newchar_list,
        map_list: newgamesettingdata['setting']?.map_list ?? []);
    state = state.copyWith(gamesettingdata: newgamesettingdata);
    gamesettingdb.put('setting', newgamesettingdata['setting']!);
  }
}
