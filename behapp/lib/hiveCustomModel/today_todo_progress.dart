import 'package:hive/hive.dart';

part 'today_todo_progress.g.dart';

@HiveType(typeId: 6)
class TodayTodoProgressObject {
  @HiveField(0)
  final String id_todo;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  int done_time;
  TodayTodoProgressObject({
    required this.id_todo,
    required this.completed,
    required this.done_time,
  });
}
