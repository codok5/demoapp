// part of 'todo_provider.dart';
// final todokey = tododb.keys;
// final todovalue = tododb.values;

// class TodoState extends Equatable {
//   final Map<dynamic, List<dynamic>> tododata;
//   TodoState({
//     required this.tododata,
//   });
//   factory TodoState.initial() {
//     return TodoState(
//       tododata: Map.fromIterables(todokey, todovalue),
//     );
//   }

//   @override
//   List<Object> get props => [tododata];

//   @override
//   String toString() => 'TodoState(tododata: $tododata)';

//   TodoState copyWith({
//     Map<dynamic, List<dynamic>>? tododata,
//   }) {
//     return TodoState(
//       tododata: tododata ?? this.tododata,
//     );
//   }
// }