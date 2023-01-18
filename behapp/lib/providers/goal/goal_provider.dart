import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';
part 'goal_state.dart';



class GoalProvider extends StateNotifier with LocatorMixin{
  GoalProvider():super(GoalState.initial());

  void makegoal(String name, String content, DateTime startday, DateTime endday, GoalType type ){
    

  }

}