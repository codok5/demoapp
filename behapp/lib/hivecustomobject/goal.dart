import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 2)
class GoalObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime startday;

  @HiveField(4)
  final DateTime endday;

  @HiveField(5)
  bool completed;
  GoalObject({
    required this.id,
    required this.name,
    required this.content,
    required this.startday,
    required this.endday,
    required this.completed,
  });
}

@HiveType(typeId: 3)
enum GoalType {
  @HiveField(6)
  binary,
  @HiveField(7)
  time,
}

@HiveType(typeId: 4)
class todoObject {
  @HiveField(8)
  final String name;

  @HiveField(9)
  final GoalType goalType;

  @HiveField(10)
  final bool completed;

  @HiveField(11)
  final int mintime;
  todoObject({
    required this.name,
    required this.goalType,
    required this.completed,
    required this.mintime,
  });
}
