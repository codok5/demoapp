// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalObjectAdapter extends TypeAdapter<GoalObject> {
  @override
  final int typeId = 2;

  @override
  GoalObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalObject(
      id: fields[0] as String,
      name: fields[1] as String,
      content: fields[2] as String,
      startday: fields[3] as DateTime,
      endday: fields[4] as DateTime,
      completed: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GoalObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.startday)
      ..writeByte(4)
      ..write(obj.endday)
      ..writeByte(5)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class todoObjectAdapter extends TypeAdapter<todoObject> {
  @override
  final int typeId = 4;

  @override
  todoObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return todoObject(
      name: fields[8] as String,
      goalType: fields[9] as GoalType,
      completed: fields[10] as bool,
      mintime: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, todoObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.goalType)
      ..writeByte(10)
      ..write(obj.completed)
      ..writeByte(11)
      ..write(obj.mintime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is todoObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 3;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 6:
        return GoalType.binary;
      case 7:
        return GoalType.time;
      default:
        return GoalType.binary;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.binary:
        writer.writeByte(6);
        break;
      case GoalType.time:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
