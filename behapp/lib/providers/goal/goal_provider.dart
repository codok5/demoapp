import 'package:behapp/hivecustomobject/goal.dart';
import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';
part 'goal_state.dart';

class GoalProvider extends StateNotifier<GoalState> with LocatorMixin {
  GoalProvider() : super(GoalState.initial());

  void makegoal({
    required String name,
    required String content,
    required DateTime startday,
    required DateTime endday,
    required GoalType goalType,
  }) {
    final String id_goal = Uuid().v1();
    final GoalObject goalObject = GoalObject(
      id_goal: id_goal,
      name: name,
      content: content,
      startday: startday,
      endday: endday,
      completed: false,
      presentprogress: 0,
      id_todo_list: [],
      goalType: goalType,
    );
    Map<dynamic, GoalObject> newgoaldata = {
      ...state.goaldata,
      id_goal: goalObject,
    };
    Map<dynamic, Map<String, dynamic>> progressmap = {
      ...state.goalprogressdata
    };
    progressmap[id_goal] = {
      'totalprogress': endday.difference(startday).inDays + 1,
      'presentprogress': 0,
      'progressstatus': GoalProgressStatus.start,
    };

    state =
        state.copyWith(goaldata: newgoaldata, goalprogressdata: progressmap);
    goaldb.put(
      id_goal,
      goalObject,
    );
  }

  void deletegoal(String id_goal) {
    Map<dynamic, GoalObject> newgoaldata = {...state.goaldata};
    newgoaldata.remove(id_goal);
    Map<dynamic, Map<String, dynamic>> progressmap = {
      ...state.goalprogressdata
    };
    progressmap.remove(id_goal);

    state =
        state.copyWith(goaldata: newgoaldata, goalprogressdata: progressmap);
    goaldb.delete(id_goal);
  }

  void togglegoal(String id_goal) {
    GoalObject? toggledgoal = goaldb.get(id_goal);
    toggledgoal!.completed = !toggledgoal.completed;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id_goal] = toggledgoal;
    state = state.copyWith(goaldata: newgoaldata);
    goaldb.put(id_goal, toggledgoal);
  }

  void addprogress(String id_goal) {
    final Map<dynamic, Map<String, dynamic>> progressmap = {
      ...state.goalprogressdata,
    };
    progressmap[id_goal] = {
      'totalprogress': state.goalprogressdata[id_goal]!['totalprogress'],
      'presentprogress':
          state.goalprogressdata[id_goal]!['presentprogress'] + 1,
      'progressstatus':
          (state.goalprogressdata[id_goal]!['presentprogress'] + 1) /
                      state.goalprogressdata[id_goal]!['totalprogress'] >=
                  1
              ? GoalProgressStatus.completed
              : (state.goalprogressdata[id_goal]!['presentprogress'] + 1) /
                          state.goalprogressdata[id_goal]!['totalprogress'] >
                      0
                  ? GoalProgressStatus.inprogress
                  : GoalProgressStatus.start,
    };

    GoalObject? addedgoal = goaldb.get(id_goal);
    addedgoal!.presentprogress = addedgoal.presentprogress + 1;
    Map<dynamic, GoalObject> newgoaldata = state.goaldata;
    newgoaldata[id_goal] = addedgoal;
    state = state.copyWith(
      goaldata: newgoaldata,
      goalprogressdata: progressmap,
    );
    goaldb.put(id_goal, addedgoal);
  }

  void addidtodo(String id_goal, String id_todo) {
    Map<dynamic, GoalObject> goaldata = {...state.goaldata};
    goaldata[id_goal]!.id_todo_list.add(id_todo);
    state = state.copyWith(goaldata: goaldata);
    goaldb.put(id_goal, goaldata[id_goal]!);
  }

  void deleteidtodo(String id_goal, String id_todo) {
    print('a');
    Map<dynamic, GoalObject> goaldata = {...state.goaldata};
    goaldata[id_goal]!.id_todo_list.remove(id_todo);
    state = state.copyWith(goaldata: goaldata);
    goaldb.put(id_goal, goaldata[id_goal]!);
  }
}
