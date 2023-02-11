import 'package:hive/hive.dart';

part 'game_setting.g.dart';

@HiveType(typeId: 7)
class GameSettingObject {

  @HiveField(0)
  final List<String> character_list;

  @HiveField(1)
  final List<String> map_list;
  GameSettingObject({
    required this.character_list,
    required this.map_list,
  });
}
