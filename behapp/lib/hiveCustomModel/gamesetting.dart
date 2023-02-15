import 'package:hive/hive.dart';

part 'gamesetting.g.dart';

@HiveType(typeId: 7)
enum Item {
  @HiveField(0)
  sword1,
  @HiveField(1)
  sword2,
  @HiveField(2)
  hat,
}

@HiveType(typeId: 8)
enum Character {
  @HiveField(3)
  ailen,
  @HiveField(4)
  man,
}

@HiveType(typeId: 9)
enum Slot {
  @HiveField(5)
  head,
  @HiveField(6)
  righthand,
  @HiveField(7)
  lefthand,
  @HiveField(8)
  top,
  @HiveField(9)
  pants,
  @HiveField(10)
  shoe,
}
