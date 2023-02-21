// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoObjectAdapter extends TypeAdapter<TodoObject> {
  @override
  final int typeId = 5;

  @override
  TodoObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoObject(
      id_goal: fields[0] as String,
      id_todo: fields[1] as String,
      name: fields[9] as String,
      todoType: fields[10] as TodoType,
      goaltime: fields[12] as int,
      rewardcoin: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodoObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id_goal)
      ..writeByte(1)
      ..write(obj.id_todo)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.todoType)
      ..writeByte(12)
      ..write(obj.goaltime)
      ..writeByte(13)
      ..write(obj.rewardcoin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoTypeAdapter extends TypeAdapter<TodoType> {
  @override
  final int typeId = 4;

  @override
  TodoType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 17:
        return TodoType.nontimer;
      case 18:
        return TodoType.timer;
      default:
        return TodoType.nontimer;
    }
  }

  @override
  void write(BinaryWriter writer, TodoType obj) {
    switch (obj) {
      case TodoType.nontimer:
        writer.writeByte(17);
        break;
      case TodoType.timer:
        writer.writeByte(18);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
