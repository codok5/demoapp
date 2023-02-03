import 'package:behapp/hivecustomobject/todo.dart';
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 2)
enum GoalType {
  @HiveField(13)
  education,
  @HiveField(14)
  health,
  @HiveField(15)
  hobby,
  @HiveField(16)
  etc,
}

@HiveType(typeId: 3)
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
  int presentprogress;

  @HiveField(6)
  bool completed;

  @HiveField(7)
  Map<dynamic,TodoObject> todo_map;

  @HiveField(8)
  final GoalType goalType;

  GoalObject({
    required this.id,
    required this.name,
    required this.content,
    required this.startday,
    required this.endday,
    required this.presentprogress,
    required this.completed,
    required this.todo_map,
    required this.goalType,
  });
}
