part of 'goal_provider.dart';

Box<GoalObject> goaldb = Hive.box('goal');
final goalkey = goaldb.keys;
final goalvalue = goaldb.values;

Box<List<todoObject>> tododb = Hive.box('todo');

class GoalState extends Equatable {
  final Map<dynamic, GoalObject> goaldata;
  GoalState({
    required this.goaldata,
  });

  factory GoalState.initial() {
    return GoalState(
      goaldata: Map.fromIterables(goalkey, goalvalue),
    );
  }

  @override
  List<Object> get props => [goaldata];

  @override
  String toString() => 'GoalState(goaldata: $goaldata)';

  GoalState copyWith({
    Map<dynamic, GoalObject>? goaldata,
  }) {
    return GoalState(
      goaldata: goaldata ?? this.goaldata,
    );
  }
}
