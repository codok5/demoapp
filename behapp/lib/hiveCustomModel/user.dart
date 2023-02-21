import 'package:hive_flutter/hive_flutter.dart';

import 'package:behapp/hiveCustomModel/goal.dart';

part 'user.g.dart';

@HiveType(typeId: 10)
class User {
  @HiveField(0)
  int Gem;
  @HiveField(1)
  int Coin;
  @HiveField(2)
  List<GoalObject> completedGoal;
  User({
    required this.Gem,
    required this.Coin,
    required this.completedGoal,
  });
}
