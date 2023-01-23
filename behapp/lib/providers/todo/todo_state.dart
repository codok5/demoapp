part of 'todo_provider.dart';

Box<List<todoObject>> tododb = Hive.box('todo');
final todokey = tododb.keys;
final todovalue = tododb.values;

class TodoState extends Equatable {
  final Map<dynamic, List<todoObject>> tododata;
  TodoState({
    required this.tododata,
  });
  factory TodoState.initial() {
    return TodoState(
      tododata: Map.fromIterables(todokey, todovalue),
    );
  }

  @override
  List<Object> get props => [tododata];

  @override
  String toString() => 'TodoState(tododata: $tododata)';

  TodoState copyWith({
    Map<dynamic, List<todoObject>>? tododata,
  }) {
    return TodoState(
      tododata: tododata ?? this.tododata,
    );
  }
}
