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
  @HiveField(5)
  baby,
  @HiveField(6)
  boy,
}

@HiveType(typeId: 9)
enum Slot {
  @HiveField(7)
  head,
  @HiveField(8)
  righthand,
  @HiveField(9)
  lefthand,
  @HiveField(10)
  top,
  @HiveField(11)
  pants,
  @HiveField(12)
  shoe,
}
