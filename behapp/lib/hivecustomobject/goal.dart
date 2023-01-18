import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 2)
class GoalObject {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final DateTime startday;

  @HiveField(2)
  final DateTime endday;

  @HiveField(3)
  final bool completed;

  @HiveField(4)
  final GoalType goalType;
  GoalObject({
    required this.content,
    required this.startday,
    required this.endday,
    required this.completed,
    required this.goalType,
  });
}

@HiveType(typeId:3) 
enum GoalType{
  @HiveField(5)
  binary,
  @HiveField(6)
  time,
}

