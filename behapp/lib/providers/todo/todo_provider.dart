// import 'package:behapp/hivecustomobject/todo.dart';
// import 'package:behapp/providers/goal/goal_provider.dart';
// import 'package:equatable/equatable.dart';
// import 'package:state_notifier/state_notifier.dart';
// import 'package:uuid/uuid.dart';
// part 'todo_state.dart';

// class TodoProvider extends StateNotifier<TodoState> with LocatorMixin {
//   TodoProvider() : super(TodoState.initial());

//   void maketodo(
//     String id_goal,
//     String name,
//     TodoType todoType,
//     int goaltime,
//   ) async {
//     final String id_todo = Uuid().v4();
//     final TodoObject todo = TodoObject(
//       name: name,
//       todoType: todoType,
//       goaltime: goaltime,
//     );
//     List<dynamic> newtodo = [todo];
//     newtodo.addAll(tododb.get(id_todo) ?? List.empty());

//     Map<dynamic, List<dynamic>> newtododata = state.tododata;
//     newtododata[id_todo] = newtodo;
//     state = state.copyWith(tododata: newtododata);
//     tododb.put(id_todo, newtodo);
//   }

//   void deletetodo() {}
// }
