// import 'package:behapp/providers/goal/goal_provider.dart';
// import 'package:equatable/equatable.dart';
// import 'package:state_notifier/state_notifier.dart';

// part 'goal_progress_state.dart';

// class GoalProgressProvider extends StateNotifier<GoalProgressState>
//     with LocatorMixin {
//   GoalProgressProvider() : super(GoalProgressState.initial());

//   @override
//   void update(Locator watch) {
//     final goaldata = watch<GoalState>().goaldata.values;
//     Map<dynamic, Map<String, dynamic>> statusdb = state.statusdb;
//     for (var goalobject in goaldata) {
//       var value = goaldb.get(goalobject.id);
//       statusdb[goalobject.id] = {
//         'totalprogress': value!.endday.difference(value.startday).inDays + 1,
//         'presentprogress': value.presentprogress,
//         'progressstatus': value.presentprogress /
//                         value.endday.difference(value.startday).inDays +
//                     1 >
//                 0.9
//             ? GoalProgressStatus.complted
//             : value.presentprogress /
//                             value.endday.difference(value.startday).inDays +
//                         1 >
//                     0
//                 ? GoalProgressStatus.inprogress
//                 : GoalProgressStatus.start
//       };
//     }
//     state = state.copyWith(statusdb: statusdb);
//     super.update(watch);
//   }
// }
