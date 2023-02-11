// part of 'game_setting_provider.dart';

// Box<GameSettingObject> gamesettingdb = Hive.box('gamesetting');

// class GameSettingState extends Equatable {
//   final Map<dynamic, GameSettingObject> gamesettingdata;
//   GameSettingState({
//     required this.gamesettingdata,
//   });

//   factory GameSettingState.initial() {
//     return GameSettingState(
//       gamesettingdata:
//           Map.fromIterables(gamesettingdb.keys, gamesettingdb.values),
//     );
//   }

//   @override
//   List<Object> get props => [gamesettingdata];

//   @override
//   String toString() => 'GameSettingState(gamesettingdata: $gamesettingdata)';

//   GameSettingState copyWith({
//     Map<dynamic, GameSettingObject>? gamesettingdata,
//   }) {
//     return GameSettingState(
//       gamesettingdata: gamesettingdata ?? this.gamesettingdata,
//     );
//   }
// }
