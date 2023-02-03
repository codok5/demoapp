import 'package:hive/hive.dart';

part 'todo.g.dart';


@HiveType(typeId: 4)
enum TodoType {
  @HiveField(17)
  completed,
  @HiveField(18)
  time,
}

@HiveType(typeId: 5)
class TodoObject {
  @HiveField(9)
  final String name;

  @HiveField(10)
  final TodoType todoType;

  @HiveField(12)
  final int goaltime;
  TodoObject({
    required this.name,
    required this.todoType,
    required this.goaltime,
  });
}
