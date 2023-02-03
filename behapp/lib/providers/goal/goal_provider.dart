import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/hivecustomobject/today_todo_progress.dart';
import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/providers/today_progress/date_progress_provider.dart';
import 'package:behapp/utils/formatter.dart';
import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';
part 'goal_state.dart';

class GoalProvider extends StateNotifier<GoalState> with LocatorMixin {
  GoalProvider() : super(GoalState.initial());

  void makegoal(
    String name,
    String content,
    DateTime startday,
    DateTime endday,
    GoalType goalType,
  ) {
    final String id = Uuid().v1();
    final GoalObject goalObject = GoalObject(
      id: id,
      name: name,
      content: content,
      startday: startday,
      endday: endday,
      completed: false,
      presentprogress: 0,
      todo_map: {},
      goalType: goalType,
    );
    Map<dynamic, GoalObject> newgoaldata = {
      ...state.goaldata,
      id: goalObject,
    };
    Map<dynamic, Map<String, dynamic>> progressmap = state.goalprogressdata;
    progressmap[id] = {
      'totalprogress': endday.difference(startday).inDays + 1,
      'presentprogress': 0,
      'progressstatus': GoalProgressStatus.start,
    };

    state =
        state.copyWith(goaldata: newgoaldata, goalprogressdata: progressmap);
    goaldb.put(
      id,
      goalObject,
    );
  }

  void deletegoal(String id) {
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata.remove(id);
    Map<dynamic, Map<String, dynamic>> progressmap = state.goalprogressdata;
    progressmap.remove(id);
    state =
        state.copyWith(goaldata: newgoaldata, goalprogressdata: progressmap);
    goaldb.delete(id);
  }

  void togglegoal(String id) {
    GoalObject? toggledgoal = goaldb.get(id);
    toggledgoal!.completed = !toggledgoal.completed;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id] = toggledgoal;
    state = state.copyWith(goaldata: newgoaldata);
    goaldb.put(id, toggledgoal);
  }

  void addprogress(String id) {
    final Map<dynamic, Map<String, dynamic>> progressmap = {
      ...state.goalprogressdata,
    };
    progressmap[id] = {
      'totalprogress': state.goalprogressdata[id]!['totalprogress'],
      'presentprogress': state.goalprogressdata[id]!['presentprogress'] + 1,
      'progressstatus': (state.goalprogressdata[id]!['presentprogress'] + 1) /
                  state.goalprogressdata[id]!['totalprogress'] >=
              1
          ? GoalProgressStatus.completed
          : (state.goalprogressdata[id]!['presentprogress'] + 1) /
                      state.goalprogressdata[id]!['totalprogress'] >
                  0
              ? GoalProgressStatus.inprogress
              : GoalProgressStatus.start,
    };

    GoalObject? addedgoal = goaldb.get(id);
    addedgoal!.presentprogress = addedgoal.presentprogress + 1;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id] = addedgoal;
    state = state.copyWith(
      goaldata: newgoaldata,
      goalprogressdata: progressmap,
    );
    goaldb.put(id, addedgoal);
  }

  void addtodo(String id_goal, String name, TodoType todoType, int goaltime) {
    final TodoObject todoObject =
        TodoObject(name: name, todoType: todoType, goaltime: goaltime);
    final String id_todo = Uuid().v4();
    GoalObject? newgoalobject = goaldb.get(id_goal);
    final Map<dynamic, TodoObject> todo_map = {
      ...newgoalobject!.todo_map,
      id_todo: todoObject,
    };
    newgoalobject.todo_map = todo_map;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id_goal] = newgoalobject;
    state = state.copyWith(goaldata: newgoaldata);
    goaldb.put(id_goal, newgoalobject);

    List<int> dateprogressdb_keys = [];
    dateprogressdb_keys = List.generate(
        newgoalobject.endday.difference(newgoalobject.startday).inDays + 1,
        (i) => formatdatetoint(formatint.format(DateTime(
            newgoalobject.startday.year,
            newgoalobject.startday.month,
            newgoalobject.startday.day + (i)))));
    for (int key in dateprogressdb_keys) {
      dateprogressdb.put(key, [
        ...dateprogressdb.get(key) ?? [],
        TodayTodoProgressObject(
            id_todo: id_todo, completed: false, done_time: 0)
      ]);
    }
  }
}
