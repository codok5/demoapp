import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 4)
enum TodoType {
  @HiveField(17)
  nontimer,
  @HiveField(18)
  timer,
}

@HiveType(typeId: 5)
class TodoObject {
  @HiveField(0)
  final String id_goal;

  @HiveField(1)
  final String id_todo;

  @HiveField(9)
  final String name;

  @HiveField(10)
  final TodoType todoType;

  @HiveField(12)
  final int goaltime;

  @HiveField(13)
  final int rewardcoin;
  TodoObject({
    required this.id_goal,
    required this.id_todo,
    required this.name,
    required this.todoType,
    required this.goaltime,
    required this.rewardcoin,
  });

  
}
