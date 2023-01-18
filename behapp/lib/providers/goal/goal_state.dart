part of 'goal_provider.dart';

enum GoalType {
  binary,
  time,
}

class GoalState extends Equatable {
  final String name;
  final String content;
  final DateTime startday;
  final DateTime endday;
  final bool completed;
  final GoalType type;
  GoalState({
    required this.name,
    required this.content,
    required this.startday,
    required this.endday,
    required this.completed,
    required this.type,
  });

  factory GoalState.initial() {
    return GoalState(
      name: '',
      content: '',
      startday: DateTime.now(),
      endday: DateTime.now(),
      completed: false,
      type: GoalType.binary,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      content,
      startday,
      endday,
      completed,
      type,
    ];
  }

  @override
  String toString() {
    return 'GoalState(name: $name, content: $content, startday: $startday, endday: $endday, completed: $completed, type: $type)';
  }

  GoalState copyWith({
    String? name,
    String? content,
    DateTime? startday,
    DateTime? endday,
    bool? completed,
    GoalType? type,
  }) {
    return GoalState(
      name: name ?? this.name,
      content: content ?? this.content,
      startday: startday ?? this.startday,
      endday: endday ?? this.endday,
      completed: completed ?? this.completed,
      type: type ?? this.type,
    );
  }
}
