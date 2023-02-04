part of 'goal_provider.dart';

enum GoalProgressStatus {
  start,
  inprogress,
  completed,
}

Box<GoalObject> goaldb = Hive.box('goal');

final goalkey = goaldb.keys;
final goalvalue = goaldb.values;

class GoalState extends Equatable {
  final Map<dynamic, GoalObject> goaldata;
  final Map<dynamic, Map<String, dynamic>> goalprogressdata;
  GoalState({
    required this.goaldata,
    required this.goalprogressdata,
  });

  factory GoalState.initial() {
    Map<dynamic, Map<String, dynamic>> progressmap = {};
    for (var key in goalkey) {
      final value = goaldb.get(key);
      progressmap[key] = {
        'totalprogress': value != null
            ? (value.endday.difference(value.startday).inDays + 1)
            : '',
        'presentprogress': value != null ? value.presentprogress : '',
        'progressstatus': value != null &&
                value.presentprogress /
                            (value.endday.difference(value.startday).inDays +
                        1) >
                    0.9
            ? GoalProgressStatus.completed
            : value != null &&
                    value.presentprogress /
                                (value.endday.difference(value.startday).inDays +
                            1) >
                        0
                ? GoalProgressStatus.inprogress
                : value != null &&
                        value.presentprogress /
                                    (value.endday
                                        .difference(value.startday)
                                        .inDays +
                                1) ==
                            0
                    ? GoalProgressStatus.start
                    : '',
      };
    }

    return GoalState(
      goaldata: Map.fromIterables(goalkey, goalvalue),
      goalprogressdata: progressmap,
    );
  }

  @override
  List<Object> get props => [goaldata, goalprogressdata];

  @override
  String toString() =>
      'GoalState(goaldata: $goaldata, goalprogressdata: $goalprogressdata)';

  GoalState copyWith({
    Map<dynamic, GoalObject>? goaldata,
    Map<dynamic, Map<String, dynamic>>? goalprogressdata,
  }) {
    return GoalState(
      goaldata: goaldata ?? this.goaldata,
      goalprogressdata: goalprogressdata ?? this.goalprogressdata,
    );
  }
}
