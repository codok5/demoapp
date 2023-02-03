// part of 'goal_progress_provider.dart';

// enum GoalProgressStatus {
//   start,
//   inprogress,
//   complted,
// }

// class GoalProgressState extends Equatable {
//   final Map<dynamic, Map<String, dynamic>> statusdb;
//   GoalProgressState({
//     required this.statusdb,
//   });

//   factory GoalProgressState.initial() {
//     Map<dynamic, Map<String, dynamic>> statusdb = {};
//     for (var key in goalkey) {
//       var value = goaldb.get(key);
//       statusdb[key] = {
//         'totalprogress': value!.endday.difference(value.startday).inDays + 1,
//         'presentprogress': value.presentprogress,
//         'progressstatus': GoalProgressStatus.start,
//       };
//     }
//     return GoalProgressState(statusdb: statusdb);
//   }

//   @override
//   List<Object> get props => [statusdb];

//   @override
//   String toString() => 'GoalProgressState(statusdb: $statusdb)';



//   GoalProgressState copyWith({
//     Map<dynamic, Map<String, dynamic>>? statusdb,
//   }) {
//     return GoalProgressState(
//       statusdb: statusdb ?? this.statusdb,
//     );
//   }
// }
