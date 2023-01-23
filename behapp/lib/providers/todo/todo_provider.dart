import 'package:behapp/hivecustomobject/goal.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
part 'todo_state.dart';

class TodoProvider extends StateNotifier<TodoState> with LocatorMixin {
  TodoProvider() : super(TodoState.initial());

  void maketodo(
    String id,
    String name,
    GoalType goalType,
    int mintime,
  ) {
    final todoObject todo = todoObject(
      name: name,
      goalType: goalType,
      completed: false,
      mintime: mintime,
    );
    List<todoObject>? newtodo = tododb.get(id);
    newtodo!.add(todo);

    Map<dynamic, List<todoObject>> newtododata = state.tododata;
    newtododata[id] = newtodo;
    state.copyWith(tododata: newtododata);
    tododb.put(id, newtodo);
  }

  void deletetodo() {}
}
