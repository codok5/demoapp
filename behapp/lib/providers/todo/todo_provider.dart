import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/hivecustomobject/today_todo_progress.dart';
import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/goal/goal_provider.dart';

import 'package:behapp/utils/formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';
part 'todo_state.dart';

class TodoProvider extends StateNotifier<TodoState> with LocatorMixin {
  TodoProvider() : super(TodoState.initial());

  void maketodo({
    required String id_goal,
    required String name,
    required TodoType todoType,
    required int goaltime,
  }) {
    final id_todo = Uuid().v1();
    read<GoalProvider>().addidtodo(id_goal, id_todo);
    final TodoObject todoObject = TodoObject(
        id_goal: id_goal,
        id_todo: id_todo,
        name: name,
        todoType: todoType,
        goaltime: goaltime);
    final Map<dynamic, TodoObject> tododata = {
      ...state.tododata,
      id_todo: todoObject
    };
    state = state.copyWith(tododata: tododata);
    tododb.put(id_todo, todoObject);

    GoalObject? newgoalobject = goaldb.get(id_goal);

    List<int> dateprogressdb_keys = [];
    dateprogressdb_keys = List.generate(
        newgoalobject!.endday.difference(newgoalobject.startday).inDays + 1,
        (i) => formatdatetoint(formatint.format(DateTime(
            newgoalobject.startday.year,
            newgoalobject.startday.month,
            newgoalobject.startday.day + (i)))));

    for (int key in dateprogressdb_keys) {
      read<DateProgressProvider>().makedateprogress(
          key,
          TodayTodoProgressObject(
              id_todo: id_todo, completed: false, done_time: 0));
    }
  }

  void deletetodo(String id_todo) {
    final Map<dynamic, TodoObject> tododata = {...state.tododata};
    read<GoalProvider>().deleteidtodo(tododata[id_todo]!.id_goal, id_todo);
    tododata.remove(id_todo);
    state = state.copyWith(tododata: tododata);
    tododb.delete(id_todo);
    read<DateProgressProvider>().deleteprogress(id_todo);
  }
}
