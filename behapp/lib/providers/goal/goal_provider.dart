import 'package:behapp/hivecustomobject/goal.dart';
import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';
part 'goal_state.dart';

class GoalProvider extends StateNotifier<GoalState> with LocatorMixin {
  GoalProvider() : super(GoalState.initial());

  void makegoal(
      String name, String content, DateTime startday, DateTime endday) {
    final String id = Uuid().v1();
    final GoalObject goalObject = GoalObject(
      id: id,
      name: name,
      content: content,
      startday: startday,
      endday: endday,
      completed: false,
    );
    Map<dynamic, GoalObject> newgoaldata = {
      ...state.goaldata,
      id: goalObject,
    };
    state = state.copyWith(goaldata: newgoaldata);
    goaldb.put(
      id,
      goalObject,
    );
    tododb.put(
      id,
      [],
    );
  }

  void deletegoal(String id) {
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata.remove(id);
    state = state.copyWith(goaldata: newgoaldata);
    goaldb.delete(id);
    tododb.delete(id);
  }

  void togglegoal(String id) {
    GoalObject? toggledgoal = goaldb.get(id);
    toggledgoal!.completed = !toggledgoal.completed;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id] = toggledgoal;
    state.copyWith(goaldata: newgoaldata);
    goaldb.put(id, toggledgoal);
  }
}
